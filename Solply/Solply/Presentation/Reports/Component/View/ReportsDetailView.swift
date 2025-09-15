//
//  ReportsDetailView.swift
//  Solply
//
//  Created by 김승원 on 9/12/25.
//

import SwiftUI

struct ReportsDetailView: View {
    
    // MARK: - Properties
    
    @State private var editedReportsContent: String = ""
    
    private let onTextChanged: ((String) -> Void)?
    private let onPhotosSelected: (([String]) -> Void)?
    private let onCompleteAction: (() -> Void)?
    
    // MARK: - Initializer
    
    init(
        onTextChanged: ((String) -> Void)? = nil,
        onPhotosSelected: (([String]) -> Void)? = nil,
        onCompleteAction: (() -> Void)? = nil
    ) {
        self.onTextChanged = onTextChanged
        self.onPhotosSelected = onPhotosSelected
        self.onCompleteAction = onCompleteAction
    }
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .leading, spacing: 28.adjustedHeight) {
            reportsTextEditor
            
            reportsPhotosPicker
            
            Spacer()
            
            completeButton
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

// MARK: - Subviews

extension ReportsDetailView {
    private var reportsTextEditor: some View {
        VStack(alignment: .leading, spacing: 12.adjustedHeight) {
            Text("잘못된 정보에 대한 설명을 입력해주세요")
                .applySolplyFont(.body_16_m)
                .foregroundStyle(.coreBlack)
            
            SolplyTextEditor() { text in
                onTextChanged?(text)
                editedReportsContent = text
            }
        }
        .padding(.top, 16.adjustedHeight)
        .padding(.horizontal, 20.adjustedWidth)
    }
    
    private var reportsPhotosPicker: some View {
        VStack(alignment: .leading, spacing: 12.adjustedHeight) {
            HStack(alignment: .center, spacing: 4.adjustedWidth) {
                Text("관련 자료가 있다면 첨부해주세요")
                    .applySolplyFont(.body_16_m)
                    .foregroundStyle(.coreBlack)
                
                Text("(선택)")
                    .applySolplyFont(.body_16_m)
                    .foregroundStyle(.gray500)
            }
            
            SolplyPhotosPicker() { imageKeys in
                onPhotosSelected?(imageKeys)
            }
        }
        .padding(.horizontal, 20.adjustedWidth)
    }
    
    private var completeButton: some View {
        CTAMainButton(title: "완료", isEnabled: !editedReportsContent.isEmpty) {
            onCompleteAction?()
        }
        .padding(.horizontal, 20.adjustedWidth)
        .padding(.bottom, 16.adjustedHeight)
    }
}

#Preview {
    ReportsDetailView()
}
