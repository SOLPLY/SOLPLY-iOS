//
//  PolicyCell.swift
//  Solply
//
//  Created by sun on 11/3/25.
//

import SwiftUI

struct PolicyCell: View {
    
    // MARK: - Properties
    
       private let title: String
       private let isRequired: Bool
       private let isChecked: Bool
       private let showsChevron: Bool
       private let onTap: () -> Void

       // MARK: - Init
    
       init(
           title: String,
           isRequired: Bool,
           isChecked: Bool,
           showsChevron: Bool = false,
           onTap: @escaping () -> Void
       ) {
           self.title = title
           self.isRequired = isRequired
           self.isChecked = isChecked
           self.showsChevron = showsChevron
           self.onTap = onTap
       }

    var body: some View {
        Button(action: onTap) {
            HStack(alignment: .center, spacing: 4) {
                Image(isChecked ? "select-check-icon" : "default-check-icon")
                    .resizable()
                    .frame(width: 24, height: 24)

                Text("\(prefix)\(title)")
                    .applySolplyFont(.body_14_m)
                    .foregroundColor(.gray900)
                    .frame(maxWidth: .infinity, alignment: .leading)

                if showsChevron {
                    Image("arrow-right-icon-light-gray")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 12, height: 12)
                }
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }

    private var prefix: String {
        isRequired ? "(필수) " : "(선택) "
    }
}
