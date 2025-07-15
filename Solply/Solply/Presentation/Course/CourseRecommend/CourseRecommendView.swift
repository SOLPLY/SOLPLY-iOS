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

#Preview {
    CourseRecommendView()
        .environmentObject(AppCoordinator())
}

