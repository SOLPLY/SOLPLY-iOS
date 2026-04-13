//
//  PlaceComplaintView.swift
//  Solply
//
//  Created by LEESOOYONG on 3/17/26.
//

import SwiftUI

struct PlaceComplaintView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject private var appCoordinator: AppCoordinator
    
    @State private var selectedComplaintType: ComplaintType?
    @State private var content: String = ""
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            complaintTypeList
            
            if selectedComplaintType == .others {
                SolplyTextEditor(
                    onTextChanged: { text in
                        content = text
                    }
                )
            }
            
            Spacer()
            
            nextButton
        }
        .customNavigationBar(
            .backWithTitle(
                title: "신고하기",
                backAction: { appCoordinator.goBack() }
            )
        )
        .ignoresSafeArea(.keyboard)
        .onTapGesture {
            hideKeyboard()
        }
    }
}

extension PlaceComplaintView {
    
    private var isNextEnabled: Bool {
        guard let selectedComplaintType else { return false }
        
        if selectedComplaintType == .others {
            return !content
                .trimmingCharacters(in: .whitespacesAndNewlines)
                .isEmpty
        }
        
        return true
    }
    
    private var complaintTypeList: some View {
        VStack(alignment: .center, spacing: 0) {
            ForEach(ComplaintType.allCases, id: \.self) { complaint in
                SolplySelectRow(
                    title: complaint.title,
                    isSelected: selectedComplaintType == complaint,
                    hideSeparator: selectedComplaintType == complaint && complaint == .others
                ) {
                    selectedComplaintType = complaint
                }
            }
        }
        .padding(.horizontal, 20.adjustedWidth)
        .padding(.top, 16.adjustedHeight)
    }
    
    private var nextButton: some View {
        SolplyMainButton(
            title: "다음",
            isEnabled: isNextEnabled
        ) {
        }
        .padding(.horizontal, 20.adjustedWidth)
        .padding(.bottom, 16.adjustedHeight)
    }
}
