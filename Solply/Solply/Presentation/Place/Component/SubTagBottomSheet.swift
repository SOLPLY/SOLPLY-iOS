//
//  SubTagBottomSheet.swift
//  Solply
//
//  Created by seozero on 7/15/25.
//

import SwiftUI

struct SubTagBottomSheet: View {
    
    // MARK: - Properties
    
    @ObservedObject private var store: PlaceRecommendStore
    @Binding var isPresented: Bool
    
    @State private var optionTags1: [SelectableSubTag] = []
    @State private var optionTags2: [SelectableSubTag] = []
    
    private let confirmAction: (([SelectableSubTag]) -> Void)?
    
    // MARK: - Initializer
    
    init(
        store: PlaceRecommendStore,
        isPresented: Binding<Bool>,
        action: (([SelectableSubTag]) -> Void)? = nil
    ) {
        self.store = store
        self._isPresented = isPresented
        self.confirmAction = action
    }
    
    // MARK: - Body
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .center, spacing: 32.adjustedHeight) {
                    SubTagSection(
                        isPresented: $isPresented,
                        tags: $optionTags1,
                        title: "옵션 1",
                        isButtonVisible: true
                    )
                    
                    SubTagSection(
                        isPresented: $isPresented,
                        tags: $optionTags2,
                        title: "옵션 2",
                        isButtonVisible: false
                    )
                    
                    Spacer()
                }
                .padding(.top, 24.adjustedHeight)
            }
            
            HStack(alignment: .center, spacing: 12.adjustedWidth) {
                SolplySubButton(title: "초기화") {
                    optionTags1.indices.forEach { index in
                        optionTags1[index].isSelected = false
                    }
                    optionTags2.indices.forEach { index in
                        optionTags2[index].isSelected = false
                    }
                    
                    store.dispatch(.resetSubTags)
                }
                .frame(maxWidth: .infinity)
                
                SolplyMainButton(title: "완료") {
                    let selectedTags = (optionTags1 + optionTags2).filter { $0.isSelected }
                    // TODO: - 네트워크 로직 추가
                    
                    store.dispatch(.updateSubTags(selectedTags))
                    
                    confirmAction?(selectedTags)
                    
                    isPresented = false
                }
                .frame(width: 210.adjustedWidth)
            }
            .padding(.vertical, 16.adjustedHeight)
        }
        .padding(.horizontal, 16.adjustedWidth)
        .onAppear {
            let domainTags = store.state.fetchedSubTags.map {
                SubTag(id: $0.id, tagType: $0.tagType, name: $0.name)
            }

            let selectableTags = domainTags.map { tag in
                var tagModel = SelectableSubTag(from: tag)
                tagModel.isSelected = store.state.selectedSubTags.contains { $0.id == tag.id }
                return tagModel
            }

            optionTags1 = selectableTags.filter { $0.tagType == "OPTION1" }
            optionTags2 = selectableTags.filter { $0.tagType == "OPTION2" }
        }
    }
}
