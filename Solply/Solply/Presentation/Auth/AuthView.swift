//
//  AuthView.swift
//  Solply
//
//  Created by 김승원 on 6/29/25.
//

import SwiftUI

struct AuthView: View {
    
    @EnvironmentObject private var appCoordinator: AppCoordinator
    
    var body: some View {
        ZStack {
            
            VStack {
                Image(.loginGraphic)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 165.adjustedHeight)
                    .frame(maxWidth: .infinity)
                    .clipped()
                    .padding(.bottom, 60.adjustedHeight)
            }
            
            VStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    Image(.logoFullVector)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40.adjustedHeight, height: 60.35069.adjustedHeight)
                    
                    Image(.letteringVector)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 215.adjustedHeight)
                    
                    Text("혼자만의 시간을\n더 쉽게, 더 즐겁게!")
                        .applySolplyFont(.display_20_sb)
                        .foregroundColor(.gray800)
                        .padding(.top, 8.adjustedHeight)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 84.adjustedHeight)
                .padding(.horizontal, 40.adjustedHeight)
                
                Spacer()
                
                Button {
                    appCoordinator.changeRoot(to: .onboarding)
                } label: {
                    HStack(alignment: .center, spacing: 12) {
                        Image(.kakaoTalkIcon)
                            .resizable()
                            .frame(width: 28, height: 28)
                        
                        Text("카카오로 시작하기")
                            .applySolplyFont(.button_16_m)
                            .foregroundColor(Color(red: 0.1, green: 0.1, blue: 0.1))
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(red: 1, green: 0.9, blue: 0))
                    .cornerRadius(12)
                    .addBorder(
                        .roundedRectangle(cornerRadius: 12),
                        borderColor: Color(red: 0.9, green: 0.9, blue: 0.9),
                        borderWidth: 1
                    )
                    .padding(.horizontal, 24.adjustedHeight)
                    .padding(.bottom, 100.adjustedHeight)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.gray100)
    }
}

#Preview {
    AuthView()
        .environmentObject(AppCoordinator())
}
