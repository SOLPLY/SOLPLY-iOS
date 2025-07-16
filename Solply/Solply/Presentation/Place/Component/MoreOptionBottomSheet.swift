//
//  MoreOptionBottomSheet.swift
//  Solply
//
//  Created by seozero on 7/15/25.
//

import SwiftUI

struct MoreOptionBottomSheet: View {
    
    // MARK: - Properties
    
    @ObservedObject private var store: PlaceRecommendStore
    @Binding var isPresented: Bool
    
    @State private var optionTags1: [SelectableOptionTag] = []
    @State private var optionTags2: [SelectableOptionTag] = []
    
    private let action: (([SelectableOptionTag]) -> Void)?
    
    // MARK: - Initializer
    
    init(
        store: PlaceRecommendStore,
        isPresented: Binding<Bool>,
        action: (([SelectableOptionTag]) -> Void)? = nil
    ) {
        self.store = store
        self._isPresented = isPresented
        self.action = action
    }
    
    // MARK: - Body
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // 추후 확장성을 고려하고 ScrollView로 구현
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .center, spacing: 32.adjustedHeight) {
                    MoreOptionSection(
                        isPresented: $isPresented,
                        tags: $optionTags1,
                        title: "옵션 1",
                        isButtonVisible: true
                    )
                    
                    MoreOptionSection(
                        isPresented: $isPresented,
                        tags: $optionTags2,
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
                    optionTags1.indices.forEach { index in
                        optionTags1[index].isSelected = false
                    }
                    optionTags2.indices.forEach { index in
                        optionTags2[index].isSelected = false
                    }
                }
                .frame(maxWidth: .infinity)
                
                CTAMainButton(title: "완료") {
                    let selectedTags = (optionTags1 + optionTags2).filter { $0.isSelected }
                    // TODO: - 네트워크 로직 추가
                    print("============== index = 0 ===============")
                    print(selectedTags[0].name)
                    print("============== count ===============")
                    print(selectedTags.count)
                    
                    store.dispatch(.confirmMoreOptionTags(selectedTags))
                    
                    action?(selectedTags)
                    
                    isPresented = false
                }
                .frame(width: 210.adjustedWidth)
            }
        }
        .padding(.horizontal, 16.adjustedWidth)
        .onAppear {
            optionTags1 = store.state.tempOptionTags
                .filter { $0.tagType == "OPTION1" }
                .map { tag in
                    var tagModel = SelectableOptionTag(from: tag)
                    tagModel.isSelected = store.state.selectedOptionTags.contains(where: { $0.id == tagModel.id })
                    return tagModel
                }
            
            optionTags2 = store.state.tempOptionTags
                .filter { $0.tagType == "OPTION2" }
                .map { tag in
                    var tagModel = SelectableOptionTag(from: tag)
                    tagModel.isSelected = store.state.selectedOptionTags.contains(where: { $0.id == tagModel.id })
                    return tagModel
                }
        }
    }
}
