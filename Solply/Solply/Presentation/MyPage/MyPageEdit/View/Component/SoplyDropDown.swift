//
//  SoplyDropDown.swift
//  Solply
//
//  Created by sun on 9/26/25.
//

import SwiftUI

public struct SoplyDropDown: View {
    
    // MARK: - Properties
    
    private let title: String
    private let options: [String]
    private let selectedText: String?
    private let onSelect: (String) -> Void
    
    @State private var isExpanded: Bool = false
    
    private var currentHeaderText: String {
        selectedText ?? title
    }
    
    private var displayOptions: [String] {
        var seen = Set<String>()
        return ([title] + options)
            .filter { seen.insert($0).inserted }
            .filter { $0 != currentHeaderText }
    }
    
    // MARK: - Initializer
    
    public init(
        title: String,
        options: [String],
        selectedText: String? = nil,
        onSelect: @escaping (String) -> Void
    ) {
        self.title = title
        self.options = options
        self.selectedText = selectedText
        self.onSelect = onSelect
    }
    
    // MARK: - Body
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            header
            if isExpanded {
                optionList
                    .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
        .background(alignment: .top) {
            if isExpanded {
                Rectangle()
                    .fill(Color(.gray200))
                    .frame(height: 52.adjustedHeight)
                    .cornerRadius(16.adjustedHeight, corners: [.topLeft, .topRight])
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

private extension SoplyDropDown {
    
    // MARK: Header
    
    var header: some View {
        Button {
            withAnimation { isExpanded.toggle() }
        } label: {
            HStack(alignment: .center, spacing: 12.adjustedWidth) {
                Text(currentHeaderText)
                    .applySolplyFont(.body_16_m)
                    .foregroundColor(.gray900)
                    .lineLimit(1)
                    .truncationMode(.tail)
                
                Spacer(minLength: 0)
                
                Image(.arrowDownLgIcon)
                    .renderingMode(.template)
                    .rotationEffect(.degrees(isExpanded ? 180 : 0))
                    .foregroundColor(.gray900)
                    .contentTransition(.symbolEffect(.replace))
                    .accessibilityHidden(true)
            }
            .padding(.horizontal, 16.adjustedWidth)
            .frame(height: 52.adjustedHeight)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .accessibilityAddTraits(.isButton)
    }
    
    // MARK: Option List
    
    var optionList: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(displayOptions.indices, id: \.self) { index in
                let text = displayOptions[index]
                
                Button {
                    withAnimation {
                        onSelect(text)
                        isExpanded = false
                    }
                } label: {
                    HStack(alignment: .center, spacing: 8.adjustedWidth) {
                        Text(text)
                            .foregroundColor(.gray900)
                            .lineLimit(1)
                            .truncationMode(.tail)
                        Spacer(minLength: 0)
                    }
                    .padding(.horizontal, 16.adjustedWidth)
                    .frame(height: 52.adjustedHeight)
                    .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                
                if index < displayOptions.count - 1 {
                    Divider()
                }
            }
        }
    }
}

// MARK: - Preview

#Preview {
    VStack(alignment: .leading, spacing: 24.adjustedHeight) {
        SoplyDropDown(
            title: "조용한 공간에 오래 머물고 싶어요",
            options: [
                "이곳저곳 둘러보고 싶어요",
                "취향이 담긴 곳을 찾고 싶어요",
                "자연을 감상하며 쉬고 싶어요"
            ],
            selectedText: nil,
            onSelect: { print("선택:", $0) }
        )
    }
    .padding(20.adjustedWidth)
}
