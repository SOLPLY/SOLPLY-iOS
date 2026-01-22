//
//  PlaceDetailView.swift
//  Solply
//
//  Created by 김승원 on 6/29/25.
//

import SwiftUI

struct PlaceDetailView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject private var appState: AppState
    @EnvironmentObject private var appCoordinator: AppCoordinator
    @EnvironmentObject private var toastManager: ToastManager
    @EnvironmentObject private var alertManager: AlertManager
    @StateObject private var store: PlaceDetailStore
    @StateObject private var locationManager = LocationManager()
    
    // MARK: - Initializer
    
    init(townId: Int, placeId: Int, fromSearch: Bool) {
        _store = StateObject(
            wrappedValue: PlaceDetailStore(
                townId: townId,
                placeId: placeId,
                fromSearch: fromSearch
            )
        )
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
        .findDirectionDialog(
            isPresented: Binding(
                get: { store.state.shouldShowFindDirectionDialog },
                set: { _ in
                    store.dispatch(.findDirectionFinished)
                }
            ),
            onFindDirectionAction: { mapRouteType in
                store.dispatch(.findDirection(mapRouteType: mapRouteType))
            }
        )
        .onAppear {
            store.dispatch(.fetchPlaceDetail)
            store.dispatch(.fetchCourseArchive)
            if appState.userSession == .authenticated {
                store.dispatch(.compareUserTownId(userTownId: appState.townId))
            }
        }
        .onReceive(locationManager.$latitude.combineLatest(locationManager.$longitude)) { latitude, longitude in
            store.dispatch(.updateUserCoordinate(latitude: latitude, longitude: longitude))
        }
        .onChange(of: store.state.toastContent) { _, toastContent in
            guard let toastContent else { return }
            
            toastManager.showToast(content: toastContent)
        }
        .onChange(of: store.state.addPlaceCourseInformation) { _, newValue in
            guard let addPlaceCourseInformation = newValue else { return }
            
            store.dispatch(
                .showToastView(
                    ToastContent(
                        toastType: .withActionToast,
                        message: "‘\(addPlaceCourseInformation.courseName.truncated(length: 8))’에 추가되었어요.",
                        toastAction: ToastAction(
                            buttonTitle: "자세히 보기",
                            action: {
                                appCoordinator.navigate(
                                    to: .courseDetail(
                                        townId: store.townId,
                                        courseId: addPlaceCourseInformation.courseId,
                                        fromArchive: true
                                    )
                                )
                            }
                        )
                    )
                )
            )
        }
    }
}

// MARK: - Subviews

extension PlaceDetailView {
    private var placeMapView: some View {
        PlaceDetailMapView(
            latitude: store.state.latitude,
            longitude: store.state.longitude,
            addButtonSelected: store.state.addButtonSelected,
            bookmarkButtonSelected: store.state.bookmarkButtonSelected,
            bookmarkButtonEnabled: store.state.bookmarkButtonEnabled,
            findDirectionEnabled: store.state.findDirectionEnabled
        )
    }
    
    private var bottomSheetContent: some View {
        ZStack {
            if !store.state.addButtonSelected {
                placeInformation
                    .customLoading(.placeInformationLoading, isLoading: store.state.isPlaceInformationLoading)
                    .transition(.move(edge: .leading))
            } else {
                addPlaceToCourse
                    .transition(.move(edge: .trailing))
            }
        }
        .animation(.easeInOut(duration: 0.3), value: store.state.addButtonSelected)
    }
    
    private var placeInformation: some View {
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
            requireLogin {
                bookmarkPlace()
            } exploreAction: {
                AmplitudeManager.shared.track(.viewLoginRequiredAlert(entryMode: .guest, blockedAction: .savePlace))
                showLoginAlert(amplitudeBlockedAction: .savePlace)
            }
        } findDirectionAction: {
            store.dispatch(.requestFindDirection)
        } addPlaceToCourseAction: {
            requireLogin {
                store.dispatch(.fetchCourseArchive)
                store.dispatch(.toggleAddToCourse)
                
                if store.state.selectedCourseIndex != -1 {
                    store.dispatch(.selectCourseToAdd(index: -1))
                }
            } exploreAction: {
                AmplitudeManager.shared.track(.viewLoginRequiredAlert(entryMode: .guest, blockedAction: .addToCourse))
                showLoginAlert(amplitudeBlockedAction: .addToCourse)
            }
        } copyAction: { text in
            store.dispatch(.copyToClipboard(text: text))
            store.dispatch(
                .showToastView(
                    ToastContent(
                        toastType: .defaultToast,
                        message: "클립보드에 복사되었습니다."
                    )
                )
            )
        } reportsAction: {
            requireLogin {
                appCoordinator.navigate(to: .reports(placeId: store.placeId))
            } exploreAction: {
                AmplitudeManager.shared.track(.viewLoginRequiredAlert(entryMode: .guest, blockedAction: .reportError))
                showLoginAlert(amplitudeBlockedAction: .reportError)
            }
        }
    }
    
    private var addPlaceToCourse: some View {
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
                            message: "해당 장소가 코스에 이미 담겨있어요."
                        )
                    )
                )
            } else if isPlaceCountLimited {
                store.dispatch(
                    .showToastView(
                        ToastContent(
                            toastType: .withIconToast,
                            message: "코스에 이미 6개의 장소가 꽉 차 있어요."
                        )
                    )
                )
            } else {
                store.dispatch(.selectCourseToAdd(index: index))
            }
        } backAction: {
            store.dispatch(.fetchCourseArchive)
            store.dispatch(.toggleAddToCourse)
            store.dispatch(.selectCourseToAdd(index: -1))
        } goToAddCourseAction: {
            appCoordinator.goToRoot()
            appCoordinator.switchTab(to: .course)
        }
    }
    
    private var addPlaceToCourseButton: some View {
        SolplyMainButton(title: "이 코스에 추가할래요") {
            let selectedCourseIndex = store.state.selectedCourseIndex
            
            store.dispatch(.toggleAddToCourse)
            store.dispatch(
                .submitAddPlace(
                    courseId: store.state.courses[selectedCourseIndex].courseId
                )
            )
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
            store.dispatch(.removePlaceBookmark)
        } else {
            store.dispatch(.submitPlaceBookmark)
        }
        
        store.dispatch(.toggleBookmarkPlace)
        
        if store.state.isBookmarked {
            store.dispatch(
                .showToastView(
                    ToastContent(
                        toastType: .defaultToast,
                        message: "장소가 수집함에 저장되었어요."
                    )
                )
            )
        }
    }
    
    private func requireLogin(_ authenticatedAction: (() -> Void), exploreAction: (() -> Void)) {
        switch appState.userSession {
        case .explore:
            exploreAction()
        case .authenticated:
            authenticatedAction()
        }
    }
    
    private func showLoginAlert(amplitudeBlockedAction: AmplitudeBlockedAction) {
        alertManager.showAlert(alertType: .authenticationRequired) {
            AmplitudeManager.shared.track(.clickLoginCancel(entryMode: .guest, blockedAction: amplitudeBlockedAction))
        } onConfirm: {
            appCoordinator.changeRoot(to: .auth)
        }
    }
}
