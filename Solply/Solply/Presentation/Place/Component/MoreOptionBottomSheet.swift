//
//  MoreOptionBottomSheet.swift
//  Solply
//
//  Created by seozero on 7/15/25.
//

import SwiftUI

struct MoreOptionBottomSheet: View {
    
    @Binding var isPresented: Bool
    
    init(isPresented: Binding<Bool>) {
        self._isPresented = isPresented
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // 추후 확장성을 고려하고 ScrollView로 구현
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .center, spacing: 32.adjustedHeight) {
                    OptionHeader(
                        isPresented: $isPresented,
                        title: "옵션 1",
                        isButtonVisible: true
                    )
                    
                    OptionHeader(
                        isPresented: $isPresented,
                        title: "옵션 2",
                        isButtonVisible: false
                    )
                    
                    Spacer()
                }
                .padding(.top, 24.adjustedHeight)
            }
            .scrollDisabled(true)
            
            HStack(alignment: .center, spacing: 12.adjustedWidth) {
                CTASubButton(title: "초기화") {
                    
                }
                .frame(maxWidth: .infinity)
                
                CTAMainButton(title: "완료") {
                    // TODO: - 네트워크 로직 추가
                    isPresented = false
                }
                .frame(width: 210.adjustedWidth)
            }
        }
        .padding(.horizontal, 16.adjustedWidth)
    }
}
