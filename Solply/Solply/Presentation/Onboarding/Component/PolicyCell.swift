//
//  PolicyCell.swift
//  Solply
//
//  Created by sun on 11/3/25.
//

import SwiftUI

struct PolicyCell: View {
    let title: String
    let isRequired: Bool
    let isChecked: Bool
    var showsChevron: Bool = false
    let onTap: () -> Void

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

#Preview {
    VStack(alignment: .leading, spacing: 16) {
        PolicyCell(
            title: "만 14세 이상입니다",
            isRequired: true,
            isChecked: true
        ) { print("첫 번째 셀") }

        PolicyCell(
            title: "서비스 이용 약관",
            isRequired: true,
            isChecked: false,
            showsChevron: true
        ) { print("두 번째") }

        PolicyCell(
            title: "개인정보 처리방침",
            isRequired: true,
            isChecked: true,
            showsChevron: true
        ) { print("세 번째") }
    }
    .padding(.horizontal, 20)
    .padding(.vertical, 16)
    .background(.gray100)
}
