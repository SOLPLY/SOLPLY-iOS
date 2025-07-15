//
//  CourseRecommendView.swift
//  Solply
//
//  Created by 김승원 on 6/28/25.
//

import SwiftUI

struct CourseRecommendView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject var appCoordinator: AppCoordinator
    //    @StateObject private var store = PlaceRecommendStore()
    
    // MARK: - Body
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 28.adjustedHeight) {
                HStack(alignment: .center, spacing: 0) {
                    Text("차분함을 좋아하는\n숭이숭이숭이숭이님을 위한 오늘의 코스")
                        .applySolplyFont(.display_20_sb)
                    Spacer()
                }
                .padding(.horizontal, 20.adjustedWidth)
                
                CourseRecommendGrid()
            }
            .frame(maxWidth: .infinity)
            .padding(.bottom, 112.adjustedHeight)
        }
        .background(.gray100)
        .customNavigationBar(.recommend(
            filterTitle: "연희동",
            // TODO: - navigation 연결하기
            filterAction: {
                
            },
            settingAction: {
                
            }
        ))
    }
}

struct CourseRecommendGrid: View {
    
    // MARK: - Properties
    
    private let columns = [
        GridItem(.fixed(165.adjustedWidth), spacing: 12.5.adjustedWidth),
        GridItem(.fixed(165.adjustedWidth))
    ]
    private let placeCategory: PlaceCategoryType = .all
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16.adjustedHeight) {
            LazyVGrid(columns: columns, spacing: 13.adjustedHeight) {
                ForEach(0..<10) { index in
                    CourseCard(
                        isSaved: true,
                        title: "오감으로 수집하는 하루",
                        courseCategory: [.book, .cafe],
                        isSelected: true
                    ) {
                        print("ㅇㅇ")
                    }
                    .frame(width: 165.adjustedWidth, height: 165.adjustedHeight)
                }
            }
        }
        .padding(.horizontal, 20.adjustedWidth)
    }
}

#Preview {
    CourseRecommendView()
        .environmentObject(AppCoordinator())
}

