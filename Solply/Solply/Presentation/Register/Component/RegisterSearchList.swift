//
//  RegisterSearchList.swift
//  Solply
//
//  Created by 김승원 on 10/11/25.
//

import SwiftUI

struct RegisterSearchList: View {
    
    // MARK: - Properties
    
    private let searchResult: [RegisterSearch]
    private let onTap: ((RegisterSearch) -> Void)?
    
    // MARK: - Initializer
    
    init(
        searchResult: [RegisterSearch],
        onTap: ((RegisterSearch) -> Void)? = nil
    ) {
        self.searchResult = searchResult
        self.onTap = onTap
    }
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("검색 결과 \(searchResult.count)개")
                .applySolplyFont(.button_14_m)
                .foregroundStyle(.gray800)
                .padding(.bottom, 16.adjustedHeight)
                .padding(.horizontal, 16.adjustedWidth)
            
            Rectangle()
                .frame(maxWidth: .infinity)
                .frame(height: 1.adjustedHeight)
                .foregroundStyle(.gray200)
            
            ForEach(searchResult) { result in
                LazyVStack(alignment: .center, spacing: 0) {
                    RegisterSearchRow(
                        placeName: result.placeName,
                        placeAddress: result.placeAddress,
                        onTap: {
                            onTap?(result)
                        }
                    )
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    RegisterSearchList(searchResult: [
        RegisterSearch(
            placeName: "공간 이름1이이이이이이이이이이이ㅣ이이이이이이이이이",
            placeAddress: "상세 주소 1 아아아아아아아아아아아아아아아ㅏ앙아아"
        ),
        RegisterSearch(
            placeName: "공간 이름2",
            placeAddress: "상세 주소2"
        ),
        RegisterSearch(
            placeName: "공간 이름3",
            placeAddress: "상세 주소3"
        )
    ])
}
