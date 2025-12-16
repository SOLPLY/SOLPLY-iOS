//
//  PolicyDetailView.swift
//  Solply
//
//  Created by sun on 12/15/25.
//

import SwiftUI

struct PolicyDetailView: View {
    let url: URL

    var body: some View {
        VStack(spacing: 0) {

            Capsule()
                .fill(Color.gray300)
                .frame(
                    width: 44.adjustedWidth,
                    height: 5.adjustedHeight
                )
                .padding(.top, 12.adjustedHeight)
                .padding(.bottom, 16.adjustedHeight)

            WebView(url: url)
                .ignoresSafeArea(edges: .bottom)
        }
    }
}
