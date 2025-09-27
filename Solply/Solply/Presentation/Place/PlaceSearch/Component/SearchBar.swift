//
//  SearchBar.swift
//  Solply
//
//  Created by LEESOOYONG on 9/22/25.
//

import SwiftUI

struct SearchBarView: View {
    
    @StateObject var store : PlaceSearchStore
    
    @State private var text: String = ""
    var onChange: ((String) -> Void)?
    var onSubmit: ((String) -> Void)?
    
    var body: some View {
        HStack {
            ZStack(alignment: .leading) {
                if text.isEmpty {
                    Text("찾는 장소를 입력하세요")
                        .applySolplyFont(.body_16_r)
                        .foregroundColor(.gray500)
                        .padding(.leading, 20.adjustedWidth)
                }
                TextField("", text: $text)
                    .applySolplyFont(.body_16_r)
                    .foregroundColor(.coreBlack)
                    .padding(.leading, 20.adjustedWidth)
                    .padding(.vertical, 12.adjustedHeight)
                    .onChange(of: text) { _, newValue in
                        onChange?(newValue)
                        store.state.placeName = newValue
                    }
                    .onSubmit {
                        store.dispatch(.searchPlace(placeName: store.state.placeName))
                    }
            }
            
            Button {
                store.dispatch(.searchPlace(placeName: text))
                onSubmit?(text)
            } label: {
                Image(.searchIcon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24.adjustedWidth, height: 24.adjustedHeight)
                    .padding(.trailing, 20.adjustedWidth)
            }
        }
        .addBorder(
            .roundedRectangle(cornerRadius: 20.adjustedHeight),
            borderColor: .gray300,
            borderWidth: 1
        )
        .padding(.horizontal, 16.adjustedWidth)
        .padding(.top, 16.adjustedHeight)
    }
}
