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
                    
                    placeList
                }
                .padding(.top, 8.adjustedHeight)
                .padding(.horizontal, 20.adjustedWidth)
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
                            
                        } label: {
                            Image(.editingIcon)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24.adjustedWidth, height: 24.adjustedHeight)
                        }
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
        VStack(alignment: .center, spacing: 12.adjustedHeight) {
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(Array(store.state.places.enumerated()), id: \.element.id) { index, place in
                    HStack(alignment: .center, spacing: 17.adjustedWidth) {
                        NumberBadge(number: index + 1, isFocused: (store.state.focusedPlaceIndex == index))
                        
                        DraggablePlaceCell(
                            mainImageURL: "",
                            placeCategoryType: place.placeCategoryType,
                            title: place.title,
                            address: place.address,
                            isSaved: place.isSaved,
                            isFocused: (store.state.focusedPlaceIndex == index)
                        ) {
                            store.dispatch(.focusPlace(index: index))
                        } detailAction: {
                            print("detailAction")
                        } findDirectionAction: {
                            print("findDirectionAction")
                        } saveAction: {
                            store.dispatch(.toggleSavePlace(index: index))
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding(.bottom, 35.adjustedHeight)
                
            }
        }
    }
}

#Preview {
    CourseDetailView(fromeArchive: true)
        .environmentObject(AppCoordinator())
    
//    CourseDetailView(fromeArchive: false)
//        .environmentObject(AppCoordinator())
}

// MARK: - 임시 모델

struct Course {
    let courseTitle: String
    let courseDescription: String
    var places: [Place]
    
    static func mockData() -> Course {
        return Course(
            courseTitle: "오감으로 수집하는 하루우우우우우우우우우우우우우우우우우우우우우",
            courseDescription: "귀여운 당고 디저트와 커피, 에이드가 있는 펫 프렌들리 코스",
            places: [
                Place(
                    imageURL: "",
                    latitude: 37.5694,
                    longitude: 126.9246,
                    isFocused: false,
                    isSaved: true,
                    placeCategoryType: .book,
                    title: "장소 이름응응응믕믕믕믕믕응으으으으",
                    address: "상세주소오오오오오오오오오오오오오"
                ),
                Place(
                    imageURL: "",
                    latitude: 37.5689,
                    longitude: 126.9239,
                    isFocused: false,
                    isSaved: false,
                    placeCategoryType: .unique,
                    title: "장소 이름",
                    address: "상세주소"
                ),
                Place(
                    imageURL: "",
                    latitude: 37.5702,
                    longitude: 126.9253,
                    isFocused: false,
                    isSaved: true,
                    placeCategoryType: .cafe,
                    title: "장소 이름",
                    address: "상세주소"
                ),
                Place(
                    imageURL: "",
                    latitude: 37.5697,
                    longitude: 126.9260,
                    isFocused: false,
                    isSaved: false,
                    placeCategoryType: .food,
                    title: "장소 이름",
                    address: "상세주소"
                ),
                Place(
                    imageURL: "",
                    latitude: 37.5685,
                    longitude: 126.9235,
                    isFocused: false,
                    isSaved: false,
                    placeCategoryType: .shopping,
                    title: "장소 이름",
                    address: "상세주소"
                ),
                Place(
                    imageURL: "",
                    latitude: 37.5699,
                    longitude: 126.9248,
                    isFocused: false,
                    isSaved: false,
                    placeCategoryType: .book,
                    title: "장소 이름",
                    address: "상세주소"
                )
            ]
        )
    }
}

struct Place: Identifiable {
    let id = UUID()
    let imageURL: String
    let latitude: Double
    let longitude: Double
    var isFocused: Bool
    var isSaved: Bool
    let placeCategoryType: PlaceCategoryType
    let title: String
    let address: String
}
