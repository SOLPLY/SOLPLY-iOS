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
    @StateObject private var store = CourseRecommendStore()
    
    @Binding var townId: Int
    
    private let title: String
    
    // MARK: - Initializer
    
    init(title: String, townId: Binding<Int>) {
        self.title = title
        self._townId = townId
    }
    
    // MARK: - Body
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .center, spacing: 28.adjustedHeight) {
                HStack(alignment: .center, spacing: 0) {
                    Text(title)
                        .applySolplyFont(.display_20_sb)
                    Spacer()
                }
                .padding(.horizontal, 20.adjustedWidth)
                
                CourseRecommendGrid(store: store) { courseId in
                    appCoordinator.navigate(
                        to: .courseDetail(
                            townId: townId,
                            courseId: courseId,
                            fromArchive: false
                        )
                    )
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.bottom, 112.adjustedHeight)
        }
        .onChange(of: townId) { _, townId in
            store.dispatch(.fetchCourseRecommend(townId: townId))
        }
        .background(.gray100)
        .task {
            store.dispatch(.fetchCourseRecommend(townId: townId))
        }
    }
}

