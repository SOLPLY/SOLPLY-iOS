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
    
    func dispatch(_ action: PlaceComplaintAction) {
        PlaceComplaintReducer.reduce(state: &state, action: action)
        
        switch action {
        case .complaint:
            guard let selectedComplaintType = state.selectedComplaintType else { return }
            
            let trimmedContent = state.content
                .trimmingCharacters(in: .whitespacesAndNewlines)
            
            if selectedComplaintType == .others && trimmedContent.isEmpty {
                return
            }
            
            AlertManager.shared.showAlert(
                alertType: .complaint,
                onCancel: nil
            ) { [weak self] in
                self?.dispatch(.complaintSuccess)
            }
            
        case .complaintSuccess:
            break
            
        case .complaintFailed(let error):
            print(error)
            
        default:
            break
        }
    }
}
