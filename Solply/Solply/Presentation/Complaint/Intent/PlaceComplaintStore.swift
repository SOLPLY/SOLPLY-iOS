//
//  PlaceComplaintStore.swift
//  Solply
//
//  Created by sun on 4/17/26.
//

import Foundation

@MainActor
final class PlaceComplaintStore: ObservableObject {
    @Published private(set) var state = PlaceComplaintState()

    private let reviewId: Int
    private let effect: PlaceComplaintEffect

    init(
        reviewId: Int,
        effect: PlaceComplaintEffect = PlaceComplaintEffect(placeService: PlaceService())
    ) {
        self.reviewId = reviewId
        self.effect = effect
    }

    func dispatch(_ action: PlaceComplaintAction) {
        PlaceComplaintReducer.reduce(state: &state, action: action)

        switch action {
        case .complaint:
            guard let selectedComplaintType = state.selectedComplaintType else { return }

            AlertManager.shared.showAlert(
                alertType: .complaint,
                onCancel: nil
            ) { [weak self] in
                guard let self else { return }

                Task {
                    let action = await self.effect.reportReview(
                        reviewId: self.reviewId,
                        reportType: selectedComplaintType
                    )

                    self.dispatch(action)
                }
            }

        case .complaintFailed(let error):
            print(error)

        default:
            break
        }
    }
}
