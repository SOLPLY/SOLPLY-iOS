//
//  ArchiveEmptyView.swift
//  Solply
//
//  Created by LEESOOYONG on 7/9/25.
//

import SwiftUI

struct ArchiveEmptyView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject var appCoordinator: AppCoordinator

    private let archiveCategory: SolplyContentType
    
    // MARK: - Initializers

    init(archiveCategory: SolplyContentType) {
        self.archiveCategory = archiveCategory
    }
    
    // MARK: - Body

    var body: some View {
        VStack(alignment: .center, spacing: 28.adjustedHeight) {
            Text("저장한 \(archiveCategory.title)가 없어요.")
                .applySolplyFont(.body_16_m)
                .foregroundStyle(.gray800)
                .padding(.top, 215.adjustedHeight)
            
            Button {
                appCoordinator.goBack()
            } label: {
                Text("나만의 \(archiveCategory.title) 수집하러 가기")
                    .foregroundStyle(archiveCategory.title == "장소" ? .purple700 : .green800)
                    .applySolplyFont(.button_16_m)
                    .padding(.horizontal, 34.adjustedWidth)
                    .padding(.vertical, 21.5.adjustedHeight)
                    .background(archiveCategory.title == "장소" ? .purple300 : .green300)
                    .capsuleClipped()
            }
            .buttonStyle(.plain)
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(.gray100)
    }
}

#Preview {
    ArchiveEmptyView(archiveCategory: .course)
        .environmentObject(AppCoordinator())
}
