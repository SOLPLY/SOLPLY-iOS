//
//  PlaceSearchView.swift
//  Solply
//
//  Created by LEESOOYONG on 9/15/25.
//

import SwiftUI

struct PlaceSearchView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject var appCoordinator: AppCoordinator
    @StateObject var store = PlaceSearchStore()
    
    @State private var text: String = ""
    private let onChange: ((String) -> Void)?
    private let onSubmit: ((String) -> Void)?
    
    // MARK: - Initializer
    
    init(
        onChange: ((String) -> Void)? = nil,
        onSubmit: ((String) -> Void)? = nil
        
    ) {
        self.onChange = onChange
        self.onSubmit = onSubmit
    }
    
    // MARK: - Body
    
    var body: some View {
        // TODO: - VStack으로 헤더, 서치바, 목록 연결
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
                    .onChange(of: text) { _, newValue in onChange?(newValue)}
                    .onSubmit {
                        onSubmit?(text)
                    }
            }
            
            Image(.searchIcon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 24.adjustedWidth, height: 24.adjustedHeight)
                .padding(.trailing, 20.adjustedWidth)
        }
        .addBorder(
            .roundedRectangle(cornerRadius: 20.adjustedHeight),
            borderColor: .gray300,
            borderWidth: 1
        )
        .padding(.horizontal, 16.adjustedWidth)
        .padding(.top, 16.adjustedHeight)
        .customNavigationBar(.placeSearch(backAction: appCoordinator.goBack))
    }
}

#Preview {
    PlaceSearchView(
        onChange: { value in
            print("onChange: \(value)")
        },
        onSubmit: { value in
            print("onSubmit: \(value)")
        }
    )
    .environmentObject(AppCoordinator())
}
