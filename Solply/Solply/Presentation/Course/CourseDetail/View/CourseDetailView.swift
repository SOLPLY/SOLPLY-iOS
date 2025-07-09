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
    
    // MARK: - Body
    
    var body: some View {
        CourseDetailMapView(course: Course.mockData())
            .detailBottomSheet {
                bottomSheetTopButton
            } sheetContent: {
                placeList
            }
    }
}

// MARK: - Subview

extension CourseDetailView {
    private var bottomSheetTopButton: some View {
        SolplySaveButton(
            contentType: .course,
            isEnabled: true,
            isSelected: store.state.saveButtonSelected
        ) {
            store.dispatch(.toggleSaveCourse)
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
        .padding(.horizontal, 16.adjustedWidth)
    }
    
    private var placeList: some View {
        ScrollView(.vertical) {
            LazyVStack(alignment: .center, spacing: 12.adjustedHeight) {
                VStack(spacing: 12) {
                    DraggablePlaceCell(
                        mainImageURL: "주소",
                        placeCategoryType: .unique,
                        title: "장소 이름이이이이이이이이이",
                        address: "상세주소이이이이이이이이이이이이이이이이이이이이이이이잉",
                        isSaved: false
                    ) {
                        print("tapAction")
                    } detailAction: {
                        print("detailAction")
                    } findDirectionAction: {
                        print("findDirectionAction")
                    } saveAction: {
                        print("saveAction")
                    }
                    
                    DraggablePlaceCell(
                        mainImageURL: "주소",
                        placeCategoryType: .shopping,
                        title: "장소 이름",
                        address: "상세주소",
                        isSaved: true
                    ) {
                        print("tapAction")
                    } detailAction: {
                        print("detailAction")
                    } findDirectionAction: {
                        print("findDirectionAction")
                    } saveAction: {
                        print("saveAction")
                    }
                }
            }
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    CourseDetailView()
        .environmentObject(AppCoordinator())
}

// MARK: - 임시 모델

struct Course {
    let places: [Place]
    
    static func mockData() -> Course {
        return Course(
            places: [
                Place(latitude: 37.5694, longitude: 126.9246, isFocused: false),
                Place(latitude: 37.5689, longitude: 126.9239, isFocused: false),
                Place(latitude: 37.5702, longitude: 126.9253, isFocused: false),
                Place(latitude: 37.5697, longitude: 126.9260, isFocused: false),
                Place(latitude: 37.5685, longitude: 126.9235, isFocused: false),
                Place(latitude: 37.5699, longitude: 126.9248, isFocused: false)
            ]
        )
    }
}

struct Place {
    let latitude: Double
    let longitude: Double
    let isFocused: Bool
}
