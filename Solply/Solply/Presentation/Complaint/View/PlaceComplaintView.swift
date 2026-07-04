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
    @StateObject private var store: PlaceComplaintStore

    private let reviewId: Int

    // MARK: - Initializer

    init(reviewId: Int) {
        self.reviewId = reviewId
        _store = StateObject(
            wrappedValue: PlaceComplaintStore(reviewId: reviewId)
        )
    }

    // MARK: - Body

    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            complaintTypeList

            Spacer()

            nextButton
        }
        .customNavigationBar(
            .backWithTitle(
                title: "신고하기",
                backAction: { appCoordinator.goBack() }
            )
        )
        .customAlert()
        .overlay(alignment: .center) {
            if store.state.showComplaintCompleteModal {
                ComplaintCompleteModal {
                    appCoordinator.goBack()
                }
            }
        }
    }
}

extension PlaceComplaintView {

    private var isNextEnabled: Bool {
        store.state.selectedComplaintType != nil
    }

    private var complaintTypeList: some View {
        VStack(alignment: .center, spacing: 0) {
            ForEach(ComplaintType.allCases, id: \.self) { complaint in
                SolplySelectRow(
                    title: complaint.title,
                    isSelected: store.state.selectedComplaintType == complaint,
                    hideSeparator: false
                ) {
                    store.dispatch(.selectComplaintType(complaint))
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
            store.dispatch(.complaint)
        }
        .padding(.horizontal, 20.adjustedWidth)
        .padding(.bottom, 16.adjustedHeight)
    }
}
