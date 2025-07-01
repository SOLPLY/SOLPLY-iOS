//
//  CourseDetailView.swift
//  Solply
//
//  Created by 김승원 on 6/29/25.
//

import SwiftUI

struct CourseDetailView: View {
    
    @EnvironmentObject var appCoordinator: AppCoordinator
    
    var body: some View {
        VStack {
            Text("CourseDetailView")
            
            Button {
                appCoordinator.goBack()
            } label: {
                Text("goBack")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.gray)
    }
}

#Preview {
    CourseDetailView()
        .environmentObject(AppCoordinator())
}
