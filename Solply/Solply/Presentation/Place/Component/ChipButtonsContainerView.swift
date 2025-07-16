//
//  ChipButtonsContainerView.swift
//  Solply
//
//  Created by seozero on 7/16/25.
//

import SwiftUI

struct ChipButtonsContainerView: View {
    
    // MARK: - Properties
    
    @Binding var tags: [SelectableOptionTag]
    @State var totalHeight: CGFloat = .zero
    let verticalSpacing: CGFloat
    let horizontalSpacing: CGFloat
    
    // MARK: - Initializer
    
    init(
        tags: Binding<[SelectableOptionTag]>,
        verticalSpacing: CGFloat = 8,
        horizontalSpacing: CGFloat = 8,
    ) {
        self._tags = tags
        self.verticalSpacing = verticalSpacing.adjustedHeight
        self.horizontalSpacing = horizontalSpacing.adjustedWidth
    }
    
    // MARK: - Body
    
    var body: some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        
        GeometryReader { geometry in
            ZStack(alignment: .topLeading) {
                ForEach(tags.indices, id: \.self) { index in
                    MoreOptionChip(title: tags[index].name, isSelected: tags[index].isSelected)
                        .id(tags[index].id)
                        .alignmentGuide(.leading) { view in
                            if abs(width - view.width) > geometry.size.width {
                                width = 0
                                height -= view.height
                                height -= verticalSpacing
                            }
                            
                            let result = width
                            
                            if tags[index] == tags.last {
                                width = 0
                            } else {
                                width -= view.width
                                width -= horizontalSpacing
                            }
                            return result
                        }
                        .alignmentGuide(.top) { _ in
                            let result = height
                            
                            if tags[index] == tags.last {
                                height = 0
                            }
                            
                            return result
                        }
                        .onTapGesture {
                            tags[index].isSelected.toggle()
                        }
                }
            }
            .background(
                GeometryReader { proxy in
                    Color.clear
                        .onAppear {
                            totalHeight = proxy.size.height
                        }
                        .onChange(of: tags) { _, _ in
                            totalHeight = proxy.size.height
                        }
                }
            )
        }
        .frame(height: totalHeight.adjustedHeight)
    }
}
