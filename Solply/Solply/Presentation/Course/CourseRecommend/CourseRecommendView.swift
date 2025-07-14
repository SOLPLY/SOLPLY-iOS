//
//  CourseRecommendView.swift
//  Solply
//
//  Created by 김승원 on 6/28/25.
//

import SwiftUI

struct CourseRecommendView: View {
    
    @EnvironmentObject var appCoordinator: AppCoordinator
    
    var body: some View {
        ScrollView {
            VStack {
                Text("CourseRecommendView")
                
                Button {
                    appCoordinator.navigate(to: .courseDetail(fromArchive: false))
                } label: {
                    Text("코스 추천 -> 코스 상세")
                }
                
                Button {
                    appCoordinator.navigate(to: .courseDetail(fromArchive: true))
                } label: {
                    Text("수집함 -> 코스 상세")
                }
            }
            .frame(height: 1000)
            .frame(maxWidth: .infinity)
        }
        .background(.green)
    }
}

#Preview {
    CourseRecommendView()
        .environmentObject(AppCoordinator())
}
