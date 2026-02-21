//
//  CourseDetailView.swift
//  Solply
//
//  Created by 김승원 on 6/29/25.
//

import SwiftUI

struct CourseDetailView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject private var appState: AppState
    @EnvironmentObject private var appCoordinator: AppCoordinator
    @EnvironmentObject private var toastManager: ToastManager
    @EnvironmentObject private var alertManager: AlertManager
    @StateObject private var store: CourseDetailStore
    @StateObject private var locationManager = LocationManager()
    
    // MARK: - Initializer
    
    init(townId: Int, courseId: Int, fromArchive: Bool) {
        self._store = StateObject(
            wrappedValue: CourseDetailStore(
                townId: townId,
                courseId: courseId,
                fromArchive: fromArchive
            )
        )
    }
    
    // MARK: - Body
    
    var body: some View {
        ZStack(alignment: .bottom) {
            courseMapView
                
            if store.fromArchive && !store.state.isCourseEditing {
                editButton
            }
            
            if store.state.isCourseEditing {
                editingArea
            }
            
            if store.state.isSaveOptionPresented {
                saveOption
            }
        }
        .animation(.easeInOut(duration: 0.2), value: store.state.isSaveOptionPresented)
        .globalDrop() {
            store.dispatch(.endDragging)
        }
        .onAppear {
            store.dispatch(.fetchCourseDetail(courseId: store.courseId, isCourseUpdated: false))
        }
        .onReceive(locationManager.$latitude.combineLatest(locationManager.$longitude)) { latitude, longitude in
            store.dispatch(.updateUserCoordinate(latitude: latitude, longitude: longitude))
        }
        .onChange(of: store.state.toastContent) { _, toastContent in
            guard let toastContent else { return }
            
            toastManager.showToast(content: toastContent)
        }
        .findDirectionDialog(
            isPresented: Binding(
                get: { store.state.isFindDirectionDialogPresented },
                set: { _ in
                    store.dispatch(.findDirectionFinished)
                }
            ),
            onFindDirectionAction: { mapRouteType in
                store.dispatch(.findDirection(mapRouteType: mapRouteType))
            }
        )
        .sheet(
            isPresented: Binding(
                get: { store.state.isEditCourseNameSheetPresented },
                set: { store.dispatch(.showEditCourseNameSheet(isSheetPresented: $0)) }
            )
        ) {
            CourseInformationEditBottomSheet(
                courseName: store.state.courseName,
                courseDescription: store.state.courseDescription,
                dismissAction: {
                    store.dispatch(.showEditCourseNameSheet(isSheetPresented: false))
                },
                completeAction: { courseInformation in
                    store.dispatch(.showEditCourseNameSheet(isSheetPresented: false))
                    store.dispatch(.completeEditCourseInformation(courseInformation: courseInformation))
                }
            )
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
                    store.state.isCourseEditing ? showChangesNotSavedAlert() : appCoordinator.goBack()
                }, homeAction: {
                    appCoordinator.goToRoot()
                }
            ))
            .customBottomSheet(.courseDetail(fromArchive: store.fromArchive)) {
                VStack(alignment: .center, spacing: 20.adjustedHeight) {
                    title
                    
                    placeList
                }
                .customLoading(.courseDetailLoading, isLoading: store.state.isCourseDetailLoading)
            }
    }
    
    private var title: some View {
        VStack(alignment: .leading, spacing: 8.adjustedHeight) {
            Group {
                if store.fromArchive && store.state.isCourseEditing {
                    HStack(alignment: .center, spacing: 4.adjustedWidth) {
                        Text(store.state.courseName)
                            .applySolplyFont(.display_20_sb)
                            .frame(width: 307.adjustedWidth, alignment: .leading)
                        
                        Button {
                            store.dispatch(.showEditCourseNameSheet(isSheetPresented: true))
                            
                        } label: {
                            Image(.editingIcon)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 28.adjusted, height: 28.adjusted)
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
                        
                        if !store.fromArchive {
                            Button {
                                requireLogin {
                                    bookmarkCourse()
                                }
                            } label: {
                                Image(store.state.isCourseBookmarkSelected ? .bookmarkSavedIcon : .bookmarkIcon)
                                    .resizable()
                                    .renderingMode(.template)
                                    .foregroundStyle(.gray900)
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 28.adjusted, height: 28.adjusted)
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
                        isEditing: store.state.isCourseEditing
                    ) {
                        store.dispatch(.focusPlace(index: index))
                    } detailAction: {
                        appCoordinator.navigate(to: .placeDetail(townId: store.townId, placeId: store.state.places[index].placeId, fromSearch: false))
                    } findDirectionAction: {
                        store.dispatch(.requestFindDirection)
                    } saveAction: {
                        requireLogin {
                            store.dispatch(.toggleBookmarkPlace(index: index))
                            
                            if store.state.places[index].isBookmarked {
                                store.dispatch(.submitPlaceBookmark(index: index))
                                
                                store.dispatch(
                                    .showToastView(
                                        ToastContent(
                                            toastType: .defaultToast,
                                            message: "'\(place.placeName.truncated(length: 9))'가 수집함에 저장되었어요."
                                        )
                                    )
                                )
                            } else {
                                store.dispatch(.removePlaceBookmark(index: index))
                                
                                store.dispatch(
                                    .showToastView(
                                        ToastContent(
                                            toastType: .defaultToast,
                                            message: "'\(place.placeName.truncated(length: 9))'가 수집함에서 삭제되었어요."
                                        )
                                    )
                                )
                            }
                        }
                    }
                    .animation(.easeInOut(duration: 0.2), value: store.state.isCourseEditing)
                    .cornerRadius(20, corners: .allCorners)
                    .frame(maxWidth: .infinity)
                    .opacity(store.state.draggedPlace == store.state.places[index] ? 0.5 : 1)
                    .dragDrop(
                        isEditing: store.state.isCourseEditing,
                        startDragging: {
                            store.dispatch(.startDragging(draggedPlace: place))
                            
                            if store.state.dragDropState == .dragging {
                                HapticManager.shared.impact(style: .medium)
                            }
                        },
                        whileDragging: {
                            withAnimation(.interactiveSpring) {
                                store.dispatch(.whileDragging(destination: place))
                            }
                        },
                        endDragging: {
                            store.dispatch(.endDragging)
                        },
                        endWithoutDragging: {
                            store.dispatch(.endWithoutDragging)
                        }
                    )
                }
            }
            .animation(.easeInOut(duration: 0.1), value: store.state.focusedPlaceIndex)
            .padding(.bottom, 35.adjustedHeight)
            .padding(.horizontal, 20.adjustedWidth)
            
            Color(.clear)
                .frame(height: store.state.isCourseEditing ? 104.adjustedHeight : 44.adjustedHeight)
        }
        .frame(maxHeight: .infinity)
    }
    
    private var editButton: some View {
        Button {
            store.dispatch(.startEditing)
        } label: {
            Circle()
                .fill(.gray900)
                .frame(width: 64.adjusted, height: 64.adjusted)
                .overlay(alignment: .center) {
                    Image(.editingIcon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 36.adjusted, height: 36.adjusted)
                }
        }
        .buttonStyle(.plain)
        .frame(maxWidth: .infinity, alignment: .trailing)
        .padding(.trailing, 16.adjustedWidth)
        .padding(.bottom, 16.adjustedHeight)
    }
    
    private var deleteArea: some View {
        Image(store.state.isPlaceInDeleteZone ? .deleteTrueIcon : .deleteFalseIcon)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 60.adjusted, height: 60.adjusted)
            .deleteDrop(
                onDelete: {
                    store.dispatch(.droppedInDeleteZone)
                },
                onEntered: {
                    store.dispatch(.draggedInDeleteZone)
                    HapticManager.shared.impact(style: .medium)
                },
                onExited: {
                    store.dispatch(.draggedOutDeleteZone)
                    HapticManager.shared.impact(style: .medium)
                }
            )
    }
    
    private var editingArea: some View {
        VStack(alignment: .center, spacing: 16.adjustedHeight) {
            if store.fromArchive && store.state.canDeletePlace {
                deleteArea
            }
            
            SolplyMainButton(
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
                    store.dispatch(.updateCourseDetail)
                    store.dispatch(.saveCourseToCurrent)
                }
                
                CourseSaveButton(title: "새 코스로 저장") {
                    store.dispatch(.submitCreateCourseDetail)
                    store.dispatch(.saveCourseAsNew)
                    
                    store.dispatch(
                        .showToastView(
                            ToastContent(
                                toastType: .defaultToast,
                                message: "새 코스로 저장되었어요."
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
        if store.state.isCourseBookmarkSelected {
            store.dispatch(.removeCourseBookmark)
            store.dispatch(.toggleBookmarkCourse)
        } else {
            store.dispatch(.submitCourseBookmark)
            store.dispatch(.toggleBookmarkCourse)
            
            store.dispatch(
                .showToastView(
                    ToastContent(
                        toastType: .withActionToast,
                        message: "코스가 수집함에 저장되었어요.",
                        toastAction: ToastAction(
                            buttonTitle: "코스 수정하기",
                            action: {
                                appCoordinator.navigate(
                                    to: .courseDetail(
                                        townId: store.townId,
                                        courseId: store.courseId,
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
    
    private func requireLogin(_ action: (() -> Void)) {
        switch appState.userSession {
        case .explore:
            showLoginAlert()
        case .authenticated:
            action()
        }
    }
    
    private func showLoginAlert() {
        alertManager.showAlert(alertType: .authenticationRequired, onCancel: nil) {
            appCoordinator.changeRoot(to: .auth)
        }
    }
    
    private func showChangesNotSavedAlert() {
        alertManager.showAlert(alertType: .changesNotSaved, onCancel: nil) {
            appCoordinator.goBack()
        }
    }
}
