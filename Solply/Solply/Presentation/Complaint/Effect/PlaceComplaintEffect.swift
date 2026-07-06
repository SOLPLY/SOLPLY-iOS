//
//  PlaceComplaintEffect.swift
//  Solply
//
//  Created by sun on 7/4/26.
//

import Foundation

struct PlaceComplaintEffect {
    private let placeService: PlaceAPI

    init(placeService: PlaceAPI) {
        self.placeService = placeService
    }

    func reportReview(
        reviewId: Int,
        reportType: ComplaintType
    ) async -> PlaceComplaintAction {
        do {
            let request = PlaceReviewReportRequestDTO(
                reportType: reportType
            )

            _ = try await placeService.reportReview(
                reviewId: reviewId,
                request: request
            )

            return .complaintSuccess

        } catch let error as NetworkError {
            return .complaintFailed(error: error)

        } catch {
            return .complaintFailed(error: .unknownError)
        }
    }
}
