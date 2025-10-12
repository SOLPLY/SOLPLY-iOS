//
//  PlaceDetailView.swift
//  Solply
//
//  Created by 김승원 on 6/29/25.
//

import SwiftUI

struct PlaceDetailView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject private var appCoordinator: AppCoordinator
    @EnvironmentObject private var toastManager: ToastManager
    @StateObject private var store = PlaceDetailStore()
    @StateObject private var locationManager = LocationManager()
    
    private let townId: Int
    private let placeId: Int
    
    // MARK: - Initializer
    
    init(townId: Int, placeId: Int) {
        self.townId = townId
        self.placeId = placeId
    }
    
    // MARK: - Body
    
    var body: some View {
        ZStack(alignment: .bottom) {
            placeMapView
                .customNavigationBar(
                    .placeDetail(
                        backAction: {
                            appCoordinator.goBack()
                        },
                        homeAction: {
                            appCoordinator.goToRoot()
                        }
                    )
                )
                .customBottomSheet(.placeDetail) {
                    bottomSheetContent
                }
            
            if store.state.selectedCourseIndex != -1 {
                addPlaceToCourseButton
            }
        }
        .onAppear {
            store.dispatch(.fetchPlaceDetail(placeId: placeId))
            store.dispatch(.fetchCourseArchive(placeId: placeId))
        }
        .onReceive(locationManager.$latitude.combineLatest(locationManager.$longitude)) { latitude, longitude in
            store.dispatch(.updateUserCoordinate(latitude: latitude, longitude: longitude))
        }
        .onChange(of: store.state.toastContent) { _, toastContent in
            guard let toastContent else { return }
            
            toastManager.showToast(content: toastContent) {
                if let addPlaceCourseId = store.state.addPlaceCourseId {
                    appCoordinator.navigate(
                        to: .courseDetail(
                            townId: townId,
                            courseId: addPlaceCourseId,
                            fromArchive: true
                        )
                    )
                }
            }
        }
    }
}

// MARK: - Subviews

extension PlaceDetailView {
    private var placeMapView: some View {
        PlaceDetailMapView(
            latitude: store.state.latitude,
            longitude: store.state.longtitude,
            addButtonSelected: store.state.addButtonSelected,
            bookmarkButtonSelected: store.state.bookmarkButtonSelected,
            bookmarkButtonEnabled: store.state.bookmarkButtonEnabled,
            findDirectionEnabled: store.state.findDirectionEnabled
        )
    }
    
    private var bottomSheetTopButtons: some View {
        HStack(alignment: .center, spacing: 8.adjustedWidth) {
            FindDirectionButton(isEnabled: store.state.findDirectionEnabled) {
                store.dispatch(.requestFindDirection)
            }
            
            Spacer()
            
            AddToCourseButton(isSelected: store.state.addButtonSelected) {
                store.dispatch(.toggleAddToCourse)
                
                if store.state.selectedCourseIndex != -1 {
                    store.dispatch(.selectCourseToAdd(index: -1))
                }
            }
            .animation(.easeIn(duration: 0.2), value: store.state.bookmarkButtonSelected)
            
            SolplyBookmarkButton(
                isEnabled: store.state.bookmarkButtonEnabled,
                isBookmarked: store.state.isBookmarked
            ) {
                bookmarkPlace()
            }
        }
        .padding(.horizontal, 20.adjustedWidth)
    }
    
    private var bottomSheetContent: some View {
        ZStack {
            if !store.state.addButtonSelected {
                PlaceInformationView(
                    primaryTag: store.state.primaryTag,
                    placeName: store.state.placeName,
                    isBookmarked: store.state.isBookmarked,
                    introduction: store.state.introduction,
                    imageURLs: store.state.imageURLs,
                    address: store.state.address,
                    contactNumber: store.state.contactNumber,
                    openingHours: store.state.openingHours,
                    snsLink: store.state.snsLink
                ) {
                    bookmarkPlace()
                } findDirectionAction: {
                    store.dispatch(.requestFindDirection)
                } addPlaceToCourseAction: {
                    store.dispatch(.fetchCourseArchive(placeId: placeId))
                    store.dispatch(.toggleAddToCourse)
                    
                    if store.state.selectedCourseIndex != -1 {
                        store.dispatch(.selectCourseToAdd(index: -1))
                    }
                } copyAction: { text in
                    store.dispatch(.copyToClipboard(text: text))
                    store.dispatch(
                        .showToastView(
                            ToastContent(
                                toastType: .defaultToast,
                                message: "클립보드에 복사되었습니다",
                                buttonTitle: nil
                            )
                        )
                    )
                } reportsAction: {
                    appCoordinator.navigate(to: .reports(placeId: self.placeId))
                }
                .transition(.move(edge: .leading))
            } else {
                AddPlaceToCourseView(
                    courses: store.state.courses,
                    selectedIndex: store.state.selectedCourseIndex
                ) { index in
                    if index == -1 { return }
                    
                    guard index < store.state.courses.count else { return }
                    
                    guard let isDuplicated = store.state.courses[index].isDuplicated,
                          let isPlaceCountLimited = store.state.courses[index].isPlaceCountLimited else { return }
                    
                    if isDuplicated {
                        store.dispatch(
                            .showToastView(
                                ToastContent(
                                    toastType: .withIconToast,
                                    message: "해당 장소가 코스에 이미 담겨있어요.",
                                    buttonTitle: nil
                                )
                            )
                        )
                    } else if isPlaceCountLimited {
                        store.dispatch(
                            .showToastView(
                                ToastContent(
                                    toastType: .withIconToast,
                                    message: "코스에 이미 6개의 장소가 꽉 차 있어요.",
                                    buttonTitle: nil
                                )
                            )
                        )
                    } else {
                        store.dispatch(.selectCourseToAdd(index: index))
                    }
                } backAction: {
                    store.dispatch(.fetchCourseArchive(placeId: placeId))
                    store.dispatch(.toggleAddToCourse)
                    store.dispatch(.selectCourseToAdd(index: -1))
                } goToAddCourseAction: {
                    appCoordinator.goBack()
                    appCoordinator.switchTab(to: .course)
                }
                .transition(.move(edge: .trailing))
            }
        }
        .animation(.easeInOut(duration: 0.2), value: store.state.addButtonSelected)
    }
    
    private var addPlaceToCourseButton: some View {
        CTAMainButton(title: "이 코스에 추가할래요") {
            let selectedCourseIndex = store.state.selectedCourseIndex
            
            store.dispatch(
                .showToastView(
                    ToastContent(
                        toastType: .withActionToast,
                        message: "‘\(store.state.courses[selectedCourseIndex].courseName.truncated(8))’에 추가되었어요.",
                        buttonTitle: "자세히 보기"
                    )
                )
            )
            store.dispatch(
                .updateAddPlaceCourseId(
                    courseId: store.state.courses[selectedCourseIndex].courseId
                )
            )
            store.dispatch(
                .submitAddPlace(
                    courseId: store.state.courses[selectedCourseIndex].courseId,
                    placeId: placeId
                )
            )
            store.dispatch(.addPlaceToCourse(index: selectedCourseIndex))
            store.dispatch(.toggleAddToCourse)
        }
        .padding(.horizontal, 20.adjustedWidth)
        .safeAreaInset(edge: .bottom) {
            Color.clear.frame(height: 16.adjustedHeight)
        }
    }
}

// MARK: - Functions

extension PlaceDetailView {
    private func bookmarkPlace() {
        if store.state.isBookmarked {
            store.dispatch(.removePlaceBookmark(placeId: placeId))
        } else {
            store.dispatch(.submitPlaceBookmark(placeId: placeId))
        }
        
        store.dispatch(.toggleBookmarkPlace)
        
        if store.state.isBookmarked {
            store.dispatch(
                .showToastView(
                    ToastContent(
                        toastType: .defaultToast,
                        message: "장소가 수집함에 저장되었어요.",
                        buttonTitle: nil
                    )
                )
            )
        }
    }
}

#Preview {
    PlaceDetailView(townId: 1, placeId: 1)
        .environmentObject(AppCoordinator())
}
