//
//  ReportsSelectView.swift
//  Solply
//
//  Created by 김승원 on 9/11/25.
//

import SwiftUI

struct ReportsSelectView: View {
    
    // MARK: - Properties
    
    private let selectedReportsType: ReportsType?
    private let selectReportsAction: ((ReportsType) -> Void)?
    private let nextAction: (() -> Void)?
    
    // MARK: - Initializer
    
    init(
        selectedReportsType: ReportsType?,
        selectReportsAction: ((ReportsType) -> Void)? = nil,
        nextAction: (() -> Void)? = nil
    ) {
        self.selectReportsAction = selectReportsAction
        self.nextAction = nextAction
        self.selectedReportsType = selectedReportsType
    }
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            reportsSelectList
            
            Spacer()
            
            nextButton
        }
    }
}

// MARK: - Subviews

extension ReportsSelectView {
    private var reportsSelectList: some View {
        VStack(alignment: .center, spacing: 0) {
            ForEach(ReportsType.allCases, id: \.self) { reports in
                SolplySelectRow(
                    title: reports.title,
                    isSelected: selectedReportsType ?? nil == reports
                ) {
                    selectReportsAction?(reports)
                }
            }
        }
        .padding(.horizontal, 20.adjustedWidth)
        .padding(.top, 16.adjustedHeight)
    }
    
    private var nextButton: some View {
        SolplyMainButton(title: "다음", isEnabled: selectedReportsType != nil) {
            nextAction?()
        }
        .padding(.horizontal, 20.adjustedWidth)
        .padding(.bottom, 16.adjustedHeight)
    }
}
