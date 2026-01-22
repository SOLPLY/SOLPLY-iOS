//
//  OnboardingAgreementView.swift
//  Solply
//
//  Created by sun on 11/3/25.
//

import SwiftUI

struct OnboardingAgreementView: View {
    
    @ObservedObject var store: OnboardingStore
    @State private var selectedPolicyURL: URL?
    
    private var isAllAgreedUI: Bool {
        let list = store.state.policyList
        return !list.isEmpty && list.allSatisfy { $0.isAgreed }
    }
    
    private var canProceed: Bool {
        store.state.policyList
            .filter { $0.isRequired }
            .allSatisfy { $0.isAgreed }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            OnboardingOptionButton(
                title: "전체 동의",
                isSelected: isAllAgreedUI
            ) {
                store.dispatch(.toggleAllPolicies(!isAllAgreedUI))
            }
            .frame(width: 335.adjustedWidth)
            .padding(.top, 28.adjustedHeight)
            .padding(.bottom, 16.adjustedHeight)
            
            VStack(alignment: .leading, spacing: 16.adjustedHeight) {
                ForEach(store.state.policyList, id: \.id) { policy in
                    PolicyCell(
                        title: policy.title,
                        isRequired: policy.isRequired,
                        isChecked: policy.isAgreed,
                        showsChevron: policy.showsChevron,
                        onToggle: {
                            store.dispatch(.togglePolicy(id: policy.id))
                        },
                        onShowPolicy: {
                            guard let url = policy.url else { return }
                            selectedPolicyURL = url
                        }
                    )
                    .frame(width: 335.adjustedWidth, alignment: .leading)
                }
            }
            .padding(.bottom, 32.adjustedHeight)
            
            Spacer()

            SolplyMainButton(
                title: "다음",
                isEnabled: canProceed
            ) {
                // TODO: - login_entry_type 논의 필요
                AmplitudeManager.shared.track(.completeTerms(loginEntryType: .direct))
                store.dispatch(.next)
            }
            .frame(width: 335.adjustedWidth)
            .padding(.bottom, 20.adjustedHeight)
        }
        .padding(.horizontal, 0)
        .onAppear {
            if store.state.policyList.isEmpty {
                store.dispatch(.fetchPolicies)
            }
        }
        .sheet(
            isPresented: Binding(
                get: { selectedPolicyURL != nil },
                set: { presented in
                    if !presented { selectedPolicyURL = nil }
                }
            )
        ) {
            if let url = selectedPolicyURL {
                PolicyDetailView(url: url)
                    .presentationDetents([.large])
                    .presentationDragIndicator(.hidden)
            }
        }
    }
}
