//
//  MyPageView.swift
//  Solply
//
//  Created by 김승원 on 6/28/25.
//

import SwiftUI

struct MyPageView: View {
    
    @EnvironmentObject var appCoordinator: AppCoordinator
    
    var body: some View {
        VStack {
            Text("MyPageView")
            
            Button {
                appCoordinator.goBack()
            } label: {
                Text("goBack")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.pink)
    }
}

#Preview {
    MyPageView()
}
