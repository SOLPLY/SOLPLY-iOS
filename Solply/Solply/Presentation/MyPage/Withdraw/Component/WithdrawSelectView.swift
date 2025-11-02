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
    private let selectWithdrawAction: ((WithdrawType) -> Void)?
    private let withdrawAction: (() -> Void)?
    
    // MARK: - Initializer
    
    init(
        selectedWithdrawType: WithdrawType?,
        selectWithdrawAction: ((WithdrawType) -> Void)? = nil,
        withdrawAction: (() -> Void)? = nil
    ) {
        self.selectedWithdrawType = selectedWithdrawType
        self.selectWithdrawAction = selectWithdrawAction
        self.withdrawAction = withdrawAction
    }
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            withdrawSelectList
            
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
