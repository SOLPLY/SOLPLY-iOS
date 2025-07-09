//
//  ArchiveView.swift
//  Solply
//
//  Created by 이수용 on 7/9/25.
//

import SwiftUI

struct ArchiveView: View {
    
    // MARK: - Properties

    @EnvironmentObject var appCoordinator: AppCoordinator
    @StateObject var store = ArchiveStore()
    
    // MARK: - Body

    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            ArchiveBar { category in
                store.dispatch(.toggleArchiveBar(archiveCategory: category))
            }
            
            // TODO: - 데이터 연결 후 데이터 여부에 따라서 분기 처리 필요

//            ArchiveEmptyView(archiveCategory: store.state.selectedCategory)
            ArchiveFullView(archiveCatrgory: store.state.selectedCategory)
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .customNavigationBar(.archive(backAction: appCoordinator.goBack))
            
    }
}

#Preview {
    ArchiveView()
        .environmentObject(AppCoordinator())
}
