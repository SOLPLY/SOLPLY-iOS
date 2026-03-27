//
//  RecordWriteView.swift
//  Solply
//
//  Created by sun on 3/21/26.
//

import SwiftUI

struct RecordWriteView: View {
    
    // MARK: - Properties
    
    enum VisitTime: String, CaseIterable {
        case morning = "오전"
        case afternoon = "오후"
        case evening = "저녁"
    }
    
    @EnvironmentObject private var appCoordinator: AppCoordinator
    @StateObject private var store: RecordWriteStore
    
    // MARK: - Initializer
    
    init(placeName: String) {
        _store = StateObject(
            wrappedValue: RecordWriteStore(placeName: placeName)
        )
    }
    
    // MARK: - Body
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                
                VStack(alignment: .leading, spacing: 8.adjustedHeight) {
                    RecordWriteSectionHeader(title: "방문 장소")
                    placeField
                }
                
                VStack(alignment: .leading, spacing: 8.adjustedHeight) {
                    RecordWriteSectionHeader(title: "방문 날짜")
                    SolplyDatePicker(
                        selectedDate: Binding(
                            get: { store.state.selectedDate },
                            set: { store.dispatch(.selectDate($0)) }
                        )
                    )
                    visitTimeButtons
                }
                .padding(.top, 40.adjustedHeight)
                
                VStack(alignment: .leading, spacing: 8.adjustedHeight) {
                    RecordWriteSectionHeader(
                        title: "오늘의 기록",
                        showsGuide: true,
                        onGuideTapped: {
                            showModal()
                        }
                    )
                    
                    SolplyTextEditor(
                        placeholder: "오늘의 기록을 입력해주세요",
                        isTextLimitEnabled: true
                    ) { newText in
                        store.dispatch(.writeRecordText(newText))
                    }
                }
                .padding(.top, 40.adjustedHeight)
                
                VStack(alignment: .leading, spacing: 8.adjustedHeight) {
                    RecordWriteSectionHeader(title: "사진 추가 (선택)")
                    
                    SolplyPhotosPicker { imageData in
                        store.dispatch(.selectTime(imageData))
                    }
                }
                .padding(.top, 14.adjustedHeight)
            }
            .padding(.horizontal, 20.adjustedWidth)
            .padding(.bottom, 100.adjustedHeight)
        }
        .overlay(alignment: .bottom) {
            aiRecommendButton
                .padding(.horizontal, 20.adjustedWidth)
                .padding(.bottom, 4.adjustedHeight)
        }
        .customNavigationBar(.backWithTitle(title: "혼놀 기록 남기기") {
            appCoordinator.goBack()
        })
        .customModal()
    }
}

// MARK: - Subviews

extension RecordWriteView {
    
    private var placeField: some View {
        HStack(alignment: .center, spacing: 0) {
            Text(store.state.placeName)
                .applySolplyFont(.body_16_r)
                .foregroundStyle(.coreBlack)
            
            Spacer()
        }
        .padding(.horizontal, 20.adjustedWidth)
        .frame(height: 52.adjustedHeight)
        .background {
            RoundedRectangle(cornerRadius: 20)
                .fill(.coreWhite)
        }
        .addBorder(
            .roundedRectangle(cornerRadius: 20),
            borderColor: .gray300,
            borderWidth: 1
        )
    }
    
    private var visitTimeButtons: some View {
        HStack(alignment: .center, spacing: 8.adjustedWidth) {
            ForEach(VisitTime.allCases, id: \.self) { time in
                Button {
                    store.dispatch(.selectVisitTime(time))
                } label: {
                    Text(time.rawValue)
                        .applySolplyFont(.body_16_r)
                        .foregroundStyle(
                            store.state.selectedVisitTime == time ? .coreWhite : .gray900
                        )
                        .frame(maxWidth: .infinity)
                        .frame(height: 48.adjustedHeight)
                        .background {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(
                                    store.state.selectedVisitTime == time
                                    ? Color(.gray900)
                                    : Color(.gray100)
                                )
                        }
                }
                .buttonStyle(.plain)
            }
        }
    }
    
    private var aiRecommendButton: some View {
        SolplyMainButton(
            title: "등록하기",
            isEnabled: store.state.isSubmitButtonEnabled
        )
        .padding(.horizontal, 20.adjustedWidth)
        .padding(.top, 12.adjustedHeight)
        .padding(.bottom, 4.adjustedHeight)
    }
}

// MARK: - Functions

extension RecordWriteView {
    private func showModal() {
        ModalManager.shared.showModal(
            modalType: .recordWriteGuide
        )
    }
}

//// MARK: - Preview

#Preview {
    RecordWriteView(placeName: "성수동 추가해주세요")
        .environmentObject(AppCoordinator())
}
