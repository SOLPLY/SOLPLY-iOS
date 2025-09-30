//
//  CourseDetailView.swift
//  Solply
//
//  Created by 김승원 on 6/29/25.
//

import SwiftUI

struct CourseDetailView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject private var appCoordinator: AppCoordinator
    @EnvironmentObject private var toastManager: ToastManager
    @EnvironmentObject private var alertManager: AlertManager
    @StateObject private var store = CourseDetailStore()
    @StateObject private var locationManager = LocationManager()
    
    private var townId: Int
    private var courseId: Int
    private let fromArchive: Bool
    
    // MARK: - Initializer
    
    init(townId: Int, courseId: Int, fromArchive: Bool) {
        self.townId = townId
        self.courseId = courseId
        self.fromArchive = fromArchive
    }
    
    // MARK: - Body
    
    var body: some View {
        ZStack(alignment: .bottom) {
            courseMapView
                
            if fromArchive && !store.state.isEditing {
                editButton
            }
            
            if store.state.isEditing {
                editingArea
            }
            
            if store.state.isSaveOptionPresented {
                saveOption
            }
        }
        .animation(.easeInOut(duration: 0.2), value: store.state.isSaveOptionPresented)
        .onDrop(
            of: [.text],
            delegate: GlobalDropDelegate(
                onDragEnd: {
                    store.dispatch(.endDragging)
                }
            )
        )
        .onAppear {
            store.dispatch(.fetchCourseDetail(courseId: courseId))
        }
        .onReceive(locationManager.$latitude.combineLatest(locationManager.$longitude)) { latitude, longitude in
            store.dispatch(.updateUserCoordinate(latitude: latitude, longitude: longitude))
        }
        .onChange(of: store.state.updatedCourseId) { _, newValue in
            store.dispatch(.fetchCourseDetail(courseId: newValue))
        }
        .onChange(of: store.state.toastContent) { _, toastContent in
            guard let toastContent else { return }
            
            toastManager.showToast(content: toastContent) {
                appCoordinator.navigate(
                    to: .courseDetail(
                        townId: townId,
                        courseId: courseId,
                        fromArchive: true
                    )
                )
            }
        }
        .sheet(
            isPresented: Binding(
                get: { store.state.isSheetPresented },
                set: { store.dispatch(.showSheet(isSheetPresented: $0)) }
            )
        ) {
            CourseInformationEditBottomSheet(
                courseName: store.state.courseName,
                courseDescription: store.state.courseDescription
            ) {
                store.dispatch(.showSheet(isSheetPresented: false))
            } completeAction: { courseInformation in
                store.dispatch(.showSheet(isSheetPresented: false))
                store.dispatch(.completeEditCourseInformation(courseInformation: courseInformation))
            }
            .presentationDetents([.height(640.adjustedHeight)])
            .presentationCornerRadius(20)
        }
    }
}

// MARK: - Subview

extension CourseDetailView {
    private var courseMapView: some View {
        CourseDetailMapView(places: store.state.places)
            .customNavigationBar(.courseDetail(
                backAction: {
                    store.state.isEditing ? showAlert() : appCoordinator.goBack()
                }, homeAction: {
                    appCoordinator.goToRoot()
                }
            ))
            .customBottomSheet(.courseDetail(fromArchive: fromArchive)) {
                VStack(alignment: .center, spacing: 20.adjustedHeight) {
                    title
                    
                    placeList
                }
            }
    }
    
    private var title: some View {
        VStack(alignment: .leading, spacing: 8.adjustedHeight) {
            Group {
                if fromArchive && store.state.isEditing {
                    HStack(alignment: .center, spacing: 4.adjustedWidth) {
                        Text(store.state.courseName)
                            .applySolplyFont(.display_20_sb)
                            .frame(width: 307.adjustedWidth, alignment: .leading)
                        
                        Button {
                            store.dispatch(.showSheet(isSheetPresented: true))
                            
                        } label: {
                            Image(.editingIcon)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 28.adjustedWidth, height: 28.adjustedHeight)
                        }
                        .buttonStyle(.plain)
                    }
                    
                } else {
                    HStack(alignment: .center, spacing: 0) {
                        Text(store.state.courseName)
                            .applySolplyFont(.display_20_sb)
                            .foregroundStyle(.coreBlack)
                            .frame(width: 307.adjustedWidth, alignment: .leading)
                        
                        Spacer()
                        if !fromArchive {
                            Button {
                                bookmarkCourse()
                            } label: {
                                Image(store.state.courseBookmarkSelected ? .bookmarkSavedIcon : .bookmarkIcon)
                                    .resizable()
                                    .renderingMode(.template)
                                    .foregroundStyle(.gray900)
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 28.adjustedWidth, height: 28.adjustedHeight)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
            }
            .frame(height: 30.adjustedHeight)
            
            Text(store.state.courseDescription)
                .applySolplyFont(.caption_14_r)
                .foregroundStyle(.gray900)
                .frame(height: 21.adjustedHeight)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 16.adjustedWidth)
    }
    
    private var placeList: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(alignment: .center, spacing: 12.adjustedHeight) {
                ForEach(Array(store.state.places.enumerated()), id: \.element.id) { index, place in
                    DraggablePlaceCell(
                        order: index + 1,
                        mainImageURL: place.thumbnailURL,
                        placeCategoryType: place.primaryTag,
                        title: place.placeName,
                        address: place.address,
                        isSaved: place.isBookmarked,
                        isFocused: (store.state.focusedPlaceIndex == index),
                        isEditing: store.state.isEditing
                    ) {
                        store.dispatch(.focusPlace(index: index))
                    } detailAction: {
                        appCoordinator.navigate(to: .placeDetail(townId: townId, placeId: store.state.places[index].placeId))
                    } findDirectionAction: {
                        store.dispatch(.requestFindDirection(
                            destinationLatitude: store.state.places[index].latitude,
                            destinationLongitude: store.state.places[index].longitude,
                            destinationName: store.state.places[index].placeName)
                        )
                    } saveAction: {
                        store.dispatch(.toggleBookmarkPlace(index: index))
                        
                        if store.state.places[index].isBookmarked {
                            store.dispatch(.submitPlaceBookmark(placeId: store.state.places[index].placeId))
                            
                            store.dispatch(
                                .showToastView(
                                    ToastContent(
                                        toastType: .defaultToast,
                                        message: "'\(place.placeName.truncated(9))'가 수집함에 저장되었어요.",
                                        buttonTitle: nil
                                    )
                                )
                            )
                        } else {
                            store.dispatch(.removePlaceBookmark(placeId: store.state.places[index].placeId))
                            
                            store.dispatch(
                                .showToastView(
                                    ToastContent(
                                        toastType: .defaultToast,
                                        message: "'\(place.placeName.truncated(9))'가 수집함에서 삭제되었어요.",
                                        buttonTitle: nil
                                    )
                                )
                            )
                        }
                    }
                    .animation(.easeInOut(duration: 0.2), value: store.state.isEditing)
                    .cornerRadius(20, corners: .allCorners)
                    .frame(maxWidth: .infinity)
                    .opacity(store.state.draggedPlace == store.state.places[index] ? 0.5 : 1)
                    .customDragDrop(
                        isEditing: store.state.isEditing,
                        placeDetailInCourse: place,
                        placesDetailInCourse: store.state.places,
                        draggedPlace: store.state.draggedPlace,
                        startDragging: { placeDetailInCourse in
                            store.dispatch(.startDragging(draggedPlace: placeDetailInCourse))
                        },
                        whileDragging: { fromIndex, toIndex in
                            store.dispatch(.whileDragging(from: fromIndex, to: toIndex))
                        },
                        endDragging: {
                            store.dispatch(.endDragging)
                        }
                    )
                }
            }
            .animation(.easeInOut(duration: 0.1), value: store.state.focusedPlaceIndex)
            .padding(.bottom, 35.adjustedHeight)
            .padding(.horizontal, 20.adjustedWidth)
            
            Color(.clear)
                .frame(height: store.state.isEditing ? 104.adjustedHeight : 44.adjustedHeight)
        }
        .frame(maxHeight: .infinity)
    }
    
    private var editButton: some View {
        Button {
            store.dispatch(.startEditing)
        } label: {
            Circle()
                .fill(.gray900)
                .frame(width: 64.adjustedWidth, height: 64.adjustedHeight)
                .overlay(alignment: .center) {
                    Image(.editingIcon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 36.adjustedWidth, height: 36.adjustedHeight)
                }
        }
        .buttonStyle(.plain)
        .frame(maxWidth: .infinity, alignment: .trailing)
        .padding(.trailing, 16.adjustedWidth)
        .padding(.bottom, 16.adjustedHeight)
    }
    
    private var deleteArea: some View {
        Image(store.state.isInDeleteZone ? .deleteTrueIcon : .deleteFalseIcon)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 60.adjustedWidth, height: 60.adjustedHeight)
            .onDrop(
                of: [.text],
                delegate: DeleteDropDelegate(
                    draggedPlace: store.state.draggedPlace,
                    onDelete: {
                        if store.state.places.count > 2 {
                            store.dispatch(.deletePlace)
                        } else {
                            store.dispatch(
                                .showToastView(
                                    ToastContent(
                                        toastType: .withIconToast,
                                        message: "코스 안에 2개 이상의 장소가 남아있어야 해요.",
                                        buttonTitle: nil,
                                        bottomPadding: 96.adjustedHeight
                                    )
                                )
                            )
                        }
                    },
                    onEntered: {
                        store.dispatch(.draggedInDeleteZone)
                        let generator = UIImpactFeedbackGenerator(style: .medium)
                        generator.impactOccurred()
                    },
                    onExited: {
                        store.dispatch(.draggedOutDeleteZone)
                        let generator = UIImpactFeedbackGenerator(style: .medium)
                        generator.impactOccurred()
                    }
                )
            )
    }
    
    private var editingArea: some View {
        VStack(alignment: .center, spacing: 16.adjustedHeight) {
            if fromArchive && store.state.canDelete == .active {
                deleteArea
            }
            
            CTAMainButton(
                title: "완료",
                isEnabled: true
            ) {
                store.dispatch(.endEditing)
            }
            .padding(.horizontal, 20.adjustedWidth)
            .padding(.bottom, 16.adjustedHeight)
        }
    }
    
    private var saveOption: some View {
        ZStack(alignment: .bottom) {
            Color(.coreBlackO40)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
                .onTapGesture {
                    store.dispatch(.saveCourseCancel)
                }
            
            VStack(alignment: .center, spacing: 12.adjustedHeight) {
                CourseSaveButton(title: "지금 코스에 저장") {
                    store.dispatch(
                        .updateCourseDetail(
                            courseId: courseId,
                            request: CourseUpdateRequestDTO(
                                courseName: store.state.courseName,
                                courseDescription: store.state.courseDescription,
                                places: store.state.places.enumerated().map { index, place in
                                    PlaceOrderDTO(
                                        placeId: place.placeId,
                                        placeOrder: index + 1
                                    )
                                }
                            )
                        )
                    )
                    store.dispatch(.saveCourseToCurrent)
                }
                
                CourseSaveButton(title: "새 코스로 저장") {
                    store.dispatch(
                        .submitCreateCourseDetail(
                            request: CourseCreateRequestDTO(
                                courseName: store.state.courseName.removingTextAfterParenthesis(),
                                courseDescription: store.state.courseDescription,
                                places: store.state.places.enumerated().map { index, place in
                                    PlaceOrderDTO(
                                        placeId: place.placeId,
                                        placeOrder: index + 1
                                    )
                                }
                            )
                        )
                    )
                    store.dispatch(.saveCourseAsNew)
                    
                    store.dispatch(
                        .showToastView(
                            ToastContent(
                                toastType: .defaultToast,
                                message: "새 코스로 저장되었어요.",
                                buttonTitle: nil
                            )
                        )
                    )
                }
            }
            .padding(.bottom, 16.adjustedHeight)
        }
        .transition(.opacity)
        .zIndex(10)
    }
}

// MARK: - Functions {

extension CourseDetailView {
    private func bookmarkCourse() {
        if store.state.courseBookmarkSelected {
            store.dispatch(.removeCourseBookmark(courseId: courseId))
            store.dispatch(.toggleBookmarkCourse)
        } else {
            store.dispatch(.submitCourseBookmark(courseId: courseId))
            store.dispatch(.toggleBookmarkCourse)
            
            store.dispatch(
                .showToastView(
                    ToastContent(
                        toastType: .withActionToast,
                        message: "코스가 수집함에 저장되었어요.",
                        buttonTitle: "코스 수정하기"
                    )
                )
            )
        }
    }
    
    private func showAlert() {
        alertManager.showAlert(alertType: .leaveCourseDetail, onCancel: nil) {
            appCoordinator.goBack()
        }
    }
}

#Preview {
    CourseDetailView(townId: 1, courseId: 1, fromArchive: true)
        .environmentObject(AppCoordinator())
}
