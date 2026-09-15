//
//  RecordWriteView.swift
//  Solply
//
//  Created by sun on 3/21/26.
//

import SwiftUI

struct RecordWriteView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject private var appCoordinator: AppCoordinator
    @FocusState private var isFocused: Bool
    @StateObject private var store: RecordWriteStore
    
    private let textEditorId = "textEditor"

    // MARK: - Initializer
    
    init(placeId: Int, placeName: String) {
        _store = StateObject(
            wrappedValue: RecordWriteStore(placeId: placeId, placeName: placeName)
        )
    }
    
    // MARK: - Body
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    VStack(alignment: .leading, spacing: 8.adjustedHeight) {
                        RecordWriteSectionHeader(title: "방문 장소")
                        placeField
                    }
                    .padding(.horizontal, 20.adjustedWidth)

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
                    .padding(.horizontal, 20.adjustedWidth)
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
                            isTextLimitEnabled: true,
                            bottomLabel: "10자 이상 작성해주세요"
                        ) { newText in
                            store.dispatch(.writeRecordText(newText))
                        }
                        .focused($isFocused)
                    }
                    .padding(.horizontal, 20.adjustedWidth)
                    .padding(.top, 40.adjustedHeight)
                    
                    VStack(alignment: .leading, spacing: 8.adjustedHeight) {
                        RecordWriteSectionHeader(title: "사진 추가 (선택)")
                            .padding(.horizontal, 20.adjustedWidth)

                        SolplyPhotosPicker(maxSelectionCount: 5) { imageData in
                            hideKeyboard()
                            store.dispatch(.selectPhotos(imageData))
                        }
                    }
                    .padding(.top, 14.adjustedHeight)
                    
                    Rectangle()
                        .frame(height: 210.adjustedHeight)
                        .foregroundStyle(.clear)
                        .id(textEditorId)
                }
            }
            .scrollDismissesKeyboard(.interactively)
            .onChange(of: isFocused) { _, isFocused in
                if isFocused {
                    withAnimation(.easeOut(duration: 0.3)) {
                        proxy.scrollTo(textEditorId, anchor: .bottom)
                    }
                }
            }
        }
        .onTapGesture {
            hideKeyboard()
        }
        .overlay(alignment: .bottom) {
            registerRecordButton
                .padding(.bottom, 4.adjustedHeight)
        }
        .customNavigationBar(.backWithTitle(title: "혼놀 기록 남기기") {
            appCoordinator.goBack()
        })
        .ignoresSafeArea(edges: .bottom)
        .onChange(of: store.state.shouldGoBack) { _, shouldGoBack in
            if shouldGoBack {
                appCoordinator.goBack()
            }
        }
        .customModal()
    }
}

// MARK: - Subviews

extension RecordWriteView {
    
    private var placeField: some View {
        HStack(alignment: .center, spacing: 0) {
            Text(store.placeName)
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
                    Text(time.title)
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
    
    private var registerRecordButton: some View {
        SolplyMainButton(
            title: "등록하기",
            isEnabled: store.state.isSubmitButtonEnabled,
            isLoading: store.state.isLoading
        ) {
            store.dispatch(.registerRecordButtonTapped)
        }
        .padding(.horizontal, 20.adjustedWidth)
        .padding(.top, 12.adjustedHeight)
        .padding(.bottom, 40.adjustedHeight)
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
