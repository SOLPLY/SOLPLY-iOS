//
//  WithdrawSelectView.swift
//  Solply
//
//  Created by LEESOOYONG on 10/11/25.
//

import SwiftUI

struct WithdrawSelectView: View {
    
    // MARK: - Properties
    
    private let selectedWithdrawType: WithdrawType?
    @Binding private var withdrawContent: String
    private let selectWithdrawAction: ((WithdrawType) -> Void)?
    private let withdrawAction: (() -> Void)?
    
    // MARK: - Initializer
    
    init(
        selectedWithdrawType: WithdrawType?,
        withdrawContent: Binding<String> = .constant(""),
        selectWithdrawAction: ((WithdrawType) -> Void)? = nil,
        withdrawAction: (() -> Void)? = nil
    ) {
        self.selectedWithdrawType = selectedWithdrawType
        self._withdrawContent = withdrawContent
        self.selectWithdrawAction = selectWithdrawAction
        self.withdrawAction = withdrawAction
    }
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            withdrawSelectList
            
            if selectedWithdrawType == .others {
                textEditorSection
            }
            
            Spacer()
            
            withdrawButton
        }
    }
}

extension WithdrawSelectView {
    private var withdrawSelectList: some View {
        VStack(alignment: .center, spacing: 0) {
            ForEach(WithdrawType.allCases, id: \.self) { withdraws in
                SolplySelectRow(
                    title: withdraws.title,
                    isSelected: selectedWithdrawType ?? nil == withdraws
                ) {
                    selectWithdrawAction?(withdraws)
                }
            }
        }
        .padding(.horizontal, 20.adjustedWidth)
        .padding(.top, 16.adjustedHeight)
    }
    
    private var withdrawButton: some View {
        CTAMainButton(title: "탈퇴하기", isEnabled: selectedWithdrawType != nil) {
            withdrawAction?()
        }
        .padding(.horizontal, 20.adjustedWidth)
        .padding(.bottom, 16.adjustedHeight)
    }
}

extension WithdrawSelectView {
    
    private var textEditorSection: some View {
        ZStack(alignment: .topLeading) {
            TextEditor(text: $withdrawContent)
                .frame(height: 156.adjustedHeight)
                .padding(.vertical, 8.adjustedHeight)
                .padding(.horizontal, 8.adjustedWidth)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(.gray200)
                )

            if withdrawContent.isEmpty {
                Text("최대 200자 입력 가능")
                    .foregroundColor(.gray600)
                    .padding(.top, 16.adjustedHeight)
                    .padding(.leading, 16.adjustedWidth)
            }
        }
        .padding(.horizontal, 20.adjustedWidth)
    }
}
