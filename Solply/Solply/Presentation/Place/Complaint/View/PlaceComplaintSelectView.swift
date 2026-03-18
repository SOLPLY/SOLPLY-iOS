//
//  PlaceComplaintSelectView.swift
//  Solply
//
//  Created by LEESOOYONG on 3/18/26.
//

import SwiftUI

struct PlaceComplaintSelectView: View {
    
    // MARK: - Properties
    
    private let selectedComplaintType: ComplaintType?
    private let onChangeContent: ((String) -> Void)?
    
    init (
        selectedComplaintType: ComplaintType?,
        onChangeContent: ((String) -> Void)? = nil
    ) {
        self.selectedComplaintType = selectedComplaintType
        self.onChangeContent = onChangeContent
    }
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            complaintTypeList
            
            if selectedComplaintType == .others {
                SolplyTextEditor(
                    onTextChanged: { text in
                        onChangeContent?(text)
                    }
                )
            }
            
            Spacer()
            
            nextButton
        }
    }
}

extension PlaceComplaintSelectView {
    private var complaintTypeList: some View {
        VStack(alignment: .center, spacing: 0) {
            ForEach(ComplaintType.allCases, id: \.self) { complaints in
                SolplySelectRow(
                    title: complaints.title
                )
            }
        }
        .padding(.horizontal, 20.adjustedWidth)
        .padding(.top, 16.adjustedHeight)
    }
    
    private var nextButton: some View {
        SolplyMainButton(title: "다음") {
        }
        .padding(.horizontal, 20.adjustedWidth)
        .padding(.top, 16.adjustedHeight)
    }
}
