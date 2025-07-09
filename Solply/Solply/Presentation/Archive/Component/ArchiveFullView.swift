//
//  ArchiveFullView.swift
//  Solply
//
//  Created by LEESOOYONG on 7/9/25.
//

import SwiftUI

struct ArchiveFullView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject var appCoordinator: AppCoordinator
   
    private let archiveCategory: SolplyContentType
    private let columns = [GridItem(.fixed(165.adjustedWidth)), GridItem(.fixed(165.adjustedWidth))]
    private let town: [String] = ["망원동", "연희동"]
    private let title: [String] = ["오감으로 수집하는 하루", "오감자"]
    private let tags: [[PlaceCategoryType]] = [
        [.book, .food],
        [.walk, .unique]
    ]
    
    // MARK: - Initializers
    
    init(archiveCatrgory: SolplyContentType) {
        self.archiveCategory = archiveCatrgory
    }
    
    // MARK: - Body

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16.adjustedHeight) {
                ForEach(Array(town.enumerated()), id: \.offset) { index, town in
                    
                    switch archiveCategory {
                    case .place:
                        VStack(alignment: .leading, spacing: 8.adjustedHeight) {
                            ZStack {
                                Image(.place)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 165.adjustedWidth, height: 165.adjustedHeight)
                                Image(.archiveFrame)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 165.adjustedWidth, height: 165.adjustedHeight)
                            }
                            
                            Text(town)
                                .applySolplyFont(.title_15_m)
                                .padding(.leading, 8.adjustedWidth)
                        }
                    case .course:
                        VStack(alignment: .leading, spacing: 8.adjustedHeight) {
                            
                            ZStack {
                                CourseCard(isSaved: true, title: "\(title[index])", courseCategory: tags[index])
                                    .frame(width: 165.adjustedWidth, height: 165.adjustedHeight)
                                Image(.archiveFrame)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 165.adjustedWidth, height: 165.adjustedHeight)
                            }
                            
                            Text(town)
                                .applySolplyFont(.title_15_m)
                                .padding(.leading, 8.adjustedWidth)
                        }
                    }
                }
            }
            .padding(.top, 16.adjustedHeight)
        }
    }
}

#Preview {
    ArchiveFullView(archiveCatrgory: .course)
}
