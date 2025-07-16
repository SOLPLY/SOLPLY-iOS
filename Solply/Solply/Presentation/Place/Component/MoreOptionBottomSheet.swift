//
//  MoreOptionBottomSheet.swift
//  Solply
//
//  Created by seozero on 7/15/25.
//

import SwiftUI

struct MoreOptionBottomSheet: View {
    
    // MARK: - Properties
    
    @StateObject private var store = PlaceRecommendStore()
    @Binding var isPresented: Bool
    
    @State private var optionTags1: [SelectableOptionTag] = []
    @State private var optionTags2: [SelectableOptionTag] = []
    
    // MARK: - Initializer
    
    init(isPresented: Binding<Bool>) {
        self._isPresented = isPresented
    }
    
    // MARK: - Body
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // 추후 확장성을 고려하고 ScrollView로 구현
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .center, spacing: 32.adjustedHeight) {
                    VStack(alignment: .center, spacing: 20.adjustedHeight) {
                        MoreOptionHeader(
                            isPresented: $isPresented,
                            title: "옵션 1",
                            isButtonVisible: true
                        )
                        
                        ChipButtonsContainerView(tags: $optionTags1)
                    }
                    
                    VStack(alignment: .center, spacing: 20.adjustedHeight) {
                        MoreOptionHeader(
                            isPresented: $isPresented,
                            title: "옵션 2",
                            isButtonVisible: false
                        )
                        
                        ChipButtonsContainerView(tags: $optionTags2)
                    }
                        
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
        .onAppear {
            optionTags1 = store.state.tempOptionTags
                .filter { $0.tagType == "OPTION1" }
                .map { SelectableOptionTag(from: $0) }
            
            optionTags2 = store.state.tempOptionTags
                .filter { $0.tagType == "OPTION2" }
                .map { SelectableOptionTag(from: $0) }
        }
    }
}
