//
//  CourseView.swift
//  Solply
//
//  Created by 김승원 on 6/28/25.
//

import SwiftUI

struct CourseView: View {
    
    @EnvironmentObject var appCoordinator: AppCoordinator
    
    var body: some View {
        ScrollView {
            VStack {
                Text("CourseView")
                
                Button {
                    appCoordinator.navigate(to: .courseDetail)
                } label: {
                    Text("navigate to CourseDetailView")
                }
            }
            .frame(height: 1000)
            .frame(maxWidth: .infinity)
        }
        .background(.green)
    }
}

#Preview {
    CourseView()
        .environmentObject(AppCoordinator())
}
