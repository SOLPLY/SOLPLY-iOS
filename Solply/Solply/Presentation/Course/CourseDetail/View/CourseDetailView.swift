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
    
    private let fromeArchive: Bool
    
    // MARK: - Initializer
    
    init(fromeArchive: Bool) {
        self.fromeArchive = fromeArchive
    }
    
    // MARK: - Body
    
    var body: some View {
        CourseDetailMapView(places: store.state.places)
            .customNavigationBar(
                .courseDetail(
                    backAction: appCoordinator.goBack,
                    homeAction: appCoordinator.goToRoot
                )
            )
            .detailBottomSheet {
                if !fromeArchive {
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
                store.dispatch(.fetchCourseDetailData)
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
            store.dispatch(.toggleSaveCourse)
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
        .padding(.horizontal, 16.adjustedWidth)
    }
    
    private var title: some View {
        VStack(alignment: .leading, spacing: 4.adjustedHeight) {
            Group {
                if fromeArchive {
                    HStack(alignment: .center, spacing: 4.adjustedWidth) {
                        Text(store.state.courseTitle)
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
                    Text(store.state.courseTitle)
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
                                mainImageURL: "",
                                placeCategoryType: place.placeCategoryType,
                                title: place.title,
                                address: place.address,
                                isSaved: place.isSaved,
                                isFocused: (store.state.focusedPlaceIndex == index),
                                isEditing: store.state.isEditing
                            ) {
                                store.dispatch(.focusPlace(index: index))
                            } detailAction: {
                                print("detailAction")
                            } findDirectionAction: {
                                print("findDirectionAction")
                            } saveAction: {
                                store.dispatch(.toggleSavePlace(index: index))
                            }
                            .cornerRadius(20, corners: .allCorners)
                            .frame(maxWidth: .infinity)
                            .onDrag {
                                guard store.state.isEditing else {
                                    return NSItemProvider()
                                }

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
                        store.dispatch(.deletePlace)
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
}

#Preview {
    CourseDetailView(fromeArchive: true)
        .environmentObject(AppCoordinator())
}
