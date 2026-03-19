//
//  SolplyDatePicker.swift
//  Solply
//
//  Created by sun on 3/19/26.
//

import SwiftUI

struct SolplyDatePicker: View {
    
    @State private var showPicker = false
    @State private var draftDate: Date
    
    // MARK: - Properties
    
    private let selectedDate: Date?
    private let onDateSelected: (Date) -> Void
    private let today = Calendar.current.startOfDay(for: Date())
    
    // MARK: - Initializer
    
    init(
        selectedDate: Date?,
        onDateSelected: @escaping (Date) -> Void
    ) {
        self.selectedDate = selectedDate
        self.onDateSelected = onDateSelected
        self._draftDate = State(initialValue: selectedDate ?? Calendar.current.startOfDay(for: Date()))
    }
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8.adjustedHeight) {
            if let date = selectedDate {
                Text(date.yyyyMMddString)
                    .applySolplyFont(.body_16_m)
                    .foregroundColor(.gray900)
            } else {
                Text("날짜를 선택하세요")
                    .applySolplyFont(.body_16_r)
                    .foregroundColor(.gray500)
            }
        }
        .padding(.horizontal, 20.adjustedWidth)
        .frame(
            maxWidth: .infinity,
            minHeight: 52.adjustedHeight,
            alignment: .leading
        )
        .addBorder(
            .roundedRectangle(cornerRadius: 20.adjustedWidth),
            borderColor: .gray300,
            borderWidth: 1
        )
        .onTapGesture {
            draftDate = selectedDate ?? today
            showPicker = true
        }
        .sheet(isPresented: $showPicker) {
            VStack {
                DatePicker(
                    "날짜 선택",
                    selection: $draftDate,
                    in: today...,
                    displayedComponents: .date
                )
                .datePickerStyle(.wheel)
                .labelsHidden()
                .environment(\.locale, Locale(identifier: "ko_KR"))
                
                Button {
                    onDateSelected(draftDate)
                    showPicker = false
                } label: {
                    Text("완료")
                        .applySolplyFont(.title_18_sb)
                        .foregroundStyle(.gray900)
                }
            }
            .presentationDetents([.height(300.adjustedHeight)])
        }
    }
}
