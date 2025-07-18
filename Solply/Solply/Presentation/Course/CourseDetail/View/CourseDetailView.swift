//
//  CourseDetailView.swift
//  Solply
//
//  Created by 김승원 on 6/29/25.
//

import SwiftUI

struct CourseDetailView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject var appCoordinator: AppCoordinator
    @StateObject private var store = CourseDetailStore()
    @StateObject private var toastManager = ToastManager()
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
        ZStack(alignment: .center) {
            CourseDetailMapView(places: store.state.places)
                .customNavigationBar(
                    .courseDetail(backAction: {
                        if store.state.isEditing {
                            store.dispatch(.showAlert)
                        } else {
                            appCoordinator.goBack()
                        }
                    }, homeAction: {
                        appCoordinator.goToRoot()
                    })
                )
                .detailBottomSheet(maxState: .courseExpanded) {
                    if !fromArchive {
                        bottomSheetTopButton
                    }
                } sheetContent: {
                    VStack(alignment: .center, spacing: 10.adjustedHeight) {
                        title
                        
                        ZStack(alignment: .bottom) {
                            placeList
                            
                            if store.state.canDelete == .active {
                                deleteArea
                            }
                        }
                    }
                    .padding(.horizontal, 20.adjustedWidth)
                    .padding(.top, 8.adjustedHeight)
                }
                .onAppear {
                    store.dispatch(.fetchCourseDetail(courseId: courseId))
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
                .toast(toastManager: toastManager)
                .customAlert(
                    alertType: .leave,
                    title: "변경 사항을 저장하지 않고\n나가시겠어요?",
                    isPresented: store.state.isAlertPresented) {
                        store.dispatch(.cancelAlert)
                    } onConfirm: {
                        store.dispatch(.confirmAlert)
                        appCoordinator.goBack()
                    }
            
            if store.state.isSaveOptionPresented {
                saveOption
                    .transition(.opacity)
                    .zIndex(10)
            }
        }
        .onReceive(locationManager.$latitude.combineLatest(locationManager.$longitude)) { latitude, longitude in
            store.dispatch(.updateUserCoordinate(latitude: latitude, longitude: longitude))
        }
        .onChange(of: store.state.updatedCourseId) { _, newValue in
            store.dispatch(.fetchCourseDetail(courseId: newValue))
        }
    }
}

// MARK: - Subview

extension CourseDetailView {
    private var bottomSheetTopButton: some View {
        SolplySaveButton(
            contentType: .course,
            isEnabled: true,
            isSelected: store.state.courseSaveSelected
        ) {
            if store.state.courseSaveSelected {
                store.dispatch(.removeCourseBookmark(courseId: courseId))
                store.dispatch(.toggleSaveCourse)
                
            } else {
                store.dispatch(.submitCourseBookmark(courseId: courseId))
                store.dispatch(.toggleSaveCourse)
                
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
        .frame(maxWidth: .infinity, alignment: .trailing)
        .padding(.horizontal, 16.adjustedWidth)
    }
    
    private var title: some View {
        VStack(alignment: .leading, spacing: 4.adjustedHeight) {
            Group {
                if fromArchive {
                    HStack(alignment: .center, spacing: 4.adjustedWidth) {
                        Text(store.state.courseName)
                            .applySolplyFont(.title_18_sb)
                            .frame(width: 307.adjustedWidth, alignment: .leading)
                        
                        Button {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                store.dispatch(.toggleEdting)
                            }
                        } label: {
                            Image(store.state.isEditing ? .editDoneIcon : .editingIcon)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24.adjustedWidth, height: 24.adjustedHeight)
                        }
                        .buttonStyle(.plain)
                    }
                    
                } else {
                    Text(store.state.courseName)
                        .applySolplyFont(.title_18_sb)
                        .frame(width: 335.adjustedWidth, alignment: .leading)
                }
            }
            .frame(height: 23.adjustedHeight)
            
            Text(store.state.courseDescription)
                .applySolplyFont(.caption_14_r)
                .frame(maxHeight: 21.adjustedHeight)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
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
                        store.dispatch(.toggleSavePlace(index: index))
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
                    .cornerRadius(20, corners: .allCorners)
                    .frame(maxWidth: .infinity)
                    .opacity(store.state.draggedPlace == store.state.places[index] ? 0.5 : 1)
                    .onDrag {
                        guard store.state.isEditing else { return NSItemProvider() }
                        
                        let generator = UIImpactFeedbackGenerator(style: .light)
                        generator.impactOccurred()
                        
                        store.dispatch(.startDragging(draggedPlace: place))
                        return NSItemProvider()
                    }
                    .onDrop(
                        of: [.text],
                        delegate: DropViewDelegate(
                            destinationPlace: place,
                            places: store.state.places,
                            draggedPlace: store.state.draggedPlace,
                            isEditing: store.state.isEditing,
                            onMove: { fromIndex, toIndex in
                                store.dispatch(.whileDragging(from: fromIndex, to: toIndex))
                            },
                            onDragEnd: {
                                store.dispatch(.endDragging)
                            }
                        )
                    )
                    
                }
            }
            .padding(.bottom, 35.adjustedHeight)
        }
    }
    
    private var deleteArea: some View {
        Image(store.state.isInDeleteZone ? .deleteTrueIcon : .deleteFalseIcon)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 60.adjustedWidth, height: 60.adjustedHeight)
            .padding(.bottom, 26.adjustedHeight)
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
                                        buttonTitle: nil
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
    
    private var saveOption: some View {
        ZStack(alignment: .bottom) {
            Color(.coreBlackO40)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        store.dispatch(.saveCourseCancel)
                    }
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
                    withAnimation(.easeInOut(duration: 0.2)) {
                        store.dispatch(.saveCourseToCurrent)
                    }
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
                    withAnimation(.easeInOut(duration: 0.2)) {
                        store.dispatch(.saveCourseAsNew)
                    }
                    
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
    }
}

#Preview {
    CourseDetailView(townId: 1, courseId: 1, fromArchive: true)
        .environmentObject(AppCoordinator())
}
