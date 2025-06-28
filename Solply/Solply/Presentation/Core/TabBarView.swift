//
//  TabBarView.swift
//  Solply
//
//  Created by 김승원 on 6/27/25.
//

import SwiftUI

struct TabBarView: View {
    
    // MARK: - Body
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Text("hello")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.red)
            
            tabBar
                .padding(.bottom, 16.adjustedHeight)
        }
    }
}

// MARK: - Subviews

extension TabBarView {
    private var tabBar: some View {
        ZStack(alignment: .center) {
            HStack(alignment: .center, spacing: 0) {
                Spacer()
                
                MyPageButton {
                    // TODO: 마이페이지(수집함) 연결
                    print("마이페이지 탭")
                }
            }
            .padding(.horizontal, 23.adjustedWidth)
            
            SolplyTabBar { tab in
                // TODO: tab에 따라 장소, 코스 연결
                print("\(tab.title) 탭")
            }
        }
    }
}

#Preview {
    TabBarView()
}
