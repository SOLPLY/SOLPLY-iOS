//
//  SolplyDropDown.swift
//  Solply
//
//  Created by sun on 9/26/25.
//

import SwiftUI

struct SolplyDropDown: View {
    
    // MARK: - Properties
    
    private let title: String
    
    private let selectedText: String?
    private let onSelectText: ((String) -> Void)?
    
    private let selectedTag: MainTagType?
    private let onSelectTag: ((MainTagType) -> Void)?
    
    private let options: [Option]
    
    @State private var isExpanded: Bool = false
    
    private var currentHeaderText: String {
        if let selectedText { return selectedText }
        if let selectedTag { return selectedTag.title }
        return title
    }
    
    private var displayOptions: [Option] {
        options.filter { option in
            if let selectedText,
               case .text(let textValue) = option,
               textValue == selectedText { return false }
            
            if let selectedTag,
               case .tag(let mainTagType) = option,
               mainTagType == selectedTag { return false }
            
            return option.title != currentHeaderText
        }
    }
    
    // MARK: - Initializers
    
    init(
        title: String,
        options: [String],
        selectedText: String? = nil,
        onSelect: ((String) -> Void)? = nil
    ) {
        self.title = title
        self.selectedText = selectedText
        self.onSelectText = onSelect
        self.selectedTag = nil
        self.onSelectTag = nil
        
        var seen = Set<String>()
        let merged = ([title] + options).filter { seen.insert($0).inserted }
        self.options = merged.map { .text($0) }
    }
    
    init(
        title: String,
        tagOptions: [MainTagType],
        selected: MainTagType? = nil,
        onSelect: ((MainTagType) -> Void)? = nil
    ) {
        self.title = title
        self.selectedText = nil
        self.onSelectText = nil
        self.selectedTag = selected
        self.onSelectTag = onSelect
        
        self.options = tagOptions.map { .tag($0) }
    }
    
    // MARK: - Body
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            header
            if isExpanded {
                optionList
            }
        }
        .background(alignment: .top) {
            if isExpanded {
                Rectangle()
                    .fill(Color(.gray200))
                    .frame(height: 52.adjustedHeight)
                    .cornerRadius(16, corners: [.topLeft, .topRight])
                    .allowsHitTesting(false)
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 16.adjustedHeight, style: .continuous)
                .fill(Color(.coreWhite))
        )
        .addBorder(
            .roundedRectangle(cornerRadius: 16.adjustedHeight),
            borderColor: Color(.gray300),
            borderWidth: 1
        )
    }
}

// MARK: - Subviews

private extension SolplyDropDown {
    
    // MARK: Header
    
    var header: some View {
        Button {
            withAnimation(.easeInOut(duration: 0.2)) {
                isExpanded.toggle()
            }
        } label: {
            HStack(alignment: .center, spacing: 12.adjustedWidth) {
                HStack(alignment: .center, spacing: 4.adjustedWidth) {
                    if let selectedTag {
                        Image(selectedTag.icon)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24.adjustedWidth, height: 24.adjustedHeight)
                    }
                    
                    Text(currentHeaderText)
                        .applySolplyFont(.body_16_m)
                        .foregroundColor(.gray900)
                        .lineLimit(1)
                        .truncationMode(.tail)
                }
                
                Spacer(minLength: 0)
                
                Image(.arrowDownLgIcon)
                    .renderingMode(.template)
                    .rotationEffect(.degrees(isExpanded ? 180 : 0))
                    .foregroundColor(.gray900)
            }
            .padding(.horizontal, 16.adjustedWidth)
            .frame(height: 52.adjustedHeight)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
    
    // MARK: Option List
    
    var optionList: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(displayOptions.indices, id: \.self) { index in
                let option = displayOptions[index]
                
                Button {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        switch option {
                        case .text(let text):
                            onSelectText?(text)
                        case .tag(let tag):
                            onSelectTag?(tag)
                        }
                        isExpanded = false
                    }
                } label: {
                    row(for: option)
                }
                .buttonStyle(.plain)
                
                if index < displayOptions.count - 1 {
                    Divider()
                }
            }
        }
    }
    
    // MARK: - Row
    
    private func row(for option: Option) -> some View {
        HStack(alignment: .center, spacing: 8.adjustedWidth) {
            switch option {
            case .text(let textValue):
                Text(textValue)
                    .foregroundColor(.gray900)
                    .lineLimit(1)
                    .truncationMode(.tail)
                
            case .tag(let mainTagType):
                Image(mainTagType.icon)
                Text(mainTagType.title)
                    .foregroundColor(.gray900)
                    .lineLimit(1)
                    .truncationMode(.tail)
            }
            Spacer(minLength: 0)
        }
        .padding(.horizontal, 16.adjustedWidth)
        .frame(height: 52.adjustedHeight)
        .contentShape(Rectangle())
    }
}

// MARK: - Option Enum

private extension SolplyDropDown {
    enum Option {
        case text(String)
        case tag(MainTagType)
        
        var title: String {
            switch self {
            case .text(let text): return text
            case .tag(let tag): return tag.title
            }
        }
    }
}

// MARK: - Preview

#Preview {
    VStack(alignment: .leading, spacing: 24.adjustedHeight) {
        SolplyDropDown(
            title: "솔플 스타일을 선택하라우",
            options: [
                "이곳저곳 둘러보고 싶어요",
                "취향이 담긴 곳을 찾고 싶어요",
                "자연을 감상하며 쉬고 싶어요"
            ]
        )
        
        SolplyDropDown(
            title: "장소 유형을 선택해주세요",
            tagOptions: Array(MainTagType.allCases.dropFirst())
        )
    }
    .padding(20.adjustedWidth)
}
