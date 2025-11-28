//
//  SearchBar.swift
//  Solply
//
//  Created by LEESOOYONG on 9/22/25.
//

import SwiftUI

struct SearchBar: View {
    
    @State private var text: String = ""
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
                    .configureDefaultTextField()
                    .applySolplyFont(.body_16_r)
                    .foregroundColor(.coreBlack)
                    .padding(.leading, 20.adjustedWidth)
                    .padding(.vertical, 12.adjustedHeight)
                    .onSubmit {
                        onSubmit?(text)
                    }
            }
            
            Button {
                onSubmit?(text)
            } label: {
                Image(.searchIcon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24.adjusted, height: 24.adjusted)
                    .padding(.trailing, 20.adjustedWidth)
            }
        }
        .frame(height: 52.adjustedHeight)
        .addBorder(
            .roundedRectangle(cornerRadius: 20),
            borderColor: .gray300,
            borderWidth: 1
        )
        .padding(.horizontal, 16.adjustedWidth)
        .padding(.top, 16.adjustedHeight)
    }
}
