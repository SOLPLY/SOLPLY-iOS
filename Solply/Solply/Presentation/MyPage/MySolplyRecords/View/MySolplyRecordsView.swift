//
//  MySolplyRecordsView.swift
//  Solply
//
//  Created by 김승원 on 4/18/26.
//

import SwiftUI

struct MySolplyRecordsView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject private var appState: AppState
    @EnvironmentObject private var appCoordinator: AppCoordinator
    @StateObject private var store: MySolplyRecordsStore
    
    // MARK: - Initializer
    
    init() {
        _store = StateObject(wrappedValue: MySolplyRecordsStore())
    }
    
    // MARK: - Body
    
    var body: some View {
        mySolplyRecordsList
            .customLoading(.mySolplyRecordsLoading, isLoading: store.state.isLoading)
            .customNavigationBar(.backWithTitle(title: "내 솔플리 기록", backAction: {
                appCoordinator.goBack()
            }))
            .ignoresSafeArea(edges: .bottom)
            .imageViewer(
                item: store.state.imageViewerItem,
                dismissAction: { store.dispatch(.dismissImageViewer) }
            )
            .onAppear {
                store.dispatch(.onAppear)
            }
    }
}

// MARK: - Subviews

extension MySolplyRecordsView {
    private var mySolplyRecordsList: some View {
        Group {
            if store.state.mySolplyRecords.isEmpty {
                Text("등록한 기록이 없어요")
                    .applySolplyFont(.body_16_r)
                    .foregroundStyle(.gray600)
                    .padding(.top, 300.adjustedHeight)
            } else {
                ScrollView(.vertical, showsIndicators: true) {
                    LazyVStack(alignment: .center, spacing: 0) {
                        ForEach(Array(store.state.mySolplyRecords.enumerated()), id: \.offset) { index,  mySolplyRecord in
                            mySolplyRecordRow(
                                mySolplyRecord,
                                index: index,
                                hideSeparator: store.state.mySolplyRecords.count - 1 == index
                            )
                        }
                    }
                    .padding(.bottom, 90.adjustedHeight)
                }
            }
        }
    }
    
    private func mySolplyRecordRow(
        _ mySolplyRecord: MySolplyRecord,
        index: Int,
        hideSeparator: Bool
    ) -> some View {
        VStack(alignment: .leading, spacing: 16.adjustedHeight) {
            HStack(alignment: .center, spacing: 4.adjustedWidth) {
                PlaceCategoryTag(placeCategory: mySolplyRecord.placeTagType)
                
                Text(mySolplyRecord.placeName)
                    .applySolplyFont(.title_15_m)
                    .foregroundStyle(.coreBlack)
                
                Spacer()
                
                Button {
                    AlertManager.shared.showAlert(alertType: .deleteRecord, onCancel: nil) {
                        store.dispatch(.deleteRecord(index: index))
                    }
                } label: {
                    Image(.binIcon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24.adjusted, height: 24.adjusted)
                    
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal, 16.adjustedWidth)
            
            if !mySolplyRecord.PhotosUrls.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .center, spacing: 8.adjustedWidth) {
                        ForEach(Array(mySolplyRecord.PhotosUrls.enumerated()), id: \.offset) { index, thumbnailImageUrl in
                            ThumbnailImage(
                                thumbnailImageUrl,
                                width: 72.adjusted,
                                height: 72.adjusted,
                                radius: 12
                            )
                            .contentShape(Rectangle())
                            .onTapGesture {
                                store.dispatch(.presentImageViewer(index: index, imageUrls: mySolplyRecord.PhotosUrls))
                            }
                        }
                    }
                }
                .contentMargins(.horizontal, 16.adjustedWidth)
            }
            
            Text(mySolplyRecord.recordText)
                .applySolplyFont(.body_14_r)
                .foregroundStyle(.gray900)
                .padding(.horizontal, 16.adjustedWidth)
            
            Text(mySolplyRecord.visitTime)
                .applySolplyFont(.body_14_m)
                .foregroundStyle(.gray600)
                .padding(.horizontal, 16.adjustedWidth)
        }
        .padding(.vertical, 20.adjustedHeight)
        .overlay(alignment: .bottom) {
            if !hideSeparator {
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(.gray200)
                    .padding(.horizontal, 16.adjustedWidth)
            }
        }
    }
}
