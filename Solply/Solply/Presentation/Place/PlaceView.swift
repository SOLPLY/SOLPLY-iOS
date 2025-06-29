//
//  PlaceView.swift
//  Solply
//
//  Created by 김승원 on 6/28/25.
//

import SwiftUI

struct PlaceView: View {
    
    @EnvironmentObject var appCoordinator: AppCoordinator
    
    var body: some View {
        ScrollView {
            VStack {
                Text("PlaceView")
                
                Button {
                    appCoordinator.navigate(to: .placeDetail)
                } label: {
                    Text("navigate to PlaceDetailView")
                }
            }
            .frame(height: 1000)
            .frame(maxWidth: .infinity)
        }
        .background(.yellow)
    }
}

#Preview {
    PlaceView()
        .environmentObject(AppCoordinator())
}
