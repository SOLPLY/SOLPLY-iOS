//
//  PlaceInformationView.swift
//  Solply
//
//  Created by 김승원 on 7/14/25.
//

import SwiftUI

struct PlaceInformationView: View {
    
    // MARK: - Body
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .center, spacing: 16.adjustedHeight) {
                title
                
                mainImage
                
                information
            }
        }
    }
}

extension PlaceInformationView {
    private var title: some View {
        VStack(alignment: .leading, spacing: 4.adjustedHeight) {
            HStack(alignment: .center, spacing: 8.adjustedWidth) {
                PlaceCategoryTag(placeCategory: .book) // 데이터 바인딩
                
                Text("유어마인드이우이우이히우히우히우히우히웋")
                    .applySolplyFont(.title_18_sb)
                    .foregroundStyle(.coreBlack)
                    .frame(height: 23.adjustedHeight)
            }
            
            Text("귀여운 당고 디저트와 커피, 에이드가 있는 펫 프렌들리 카페입입입입입입입입입입입")
                .applySolplyFont(.caption_14_r)
                .foregroundStyle(.gray900)
                .frame(height: 21.adjustedHeight)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 20.adjustedWidth)
    }
    
    private var mainImage: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .center, spacing: 12.adjustedWidth) {
                ForEach(0..<3) { index in
                    Image(.place)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.width - 32.adjustedWidth, height: 228.adjustedHeight)
                        .cornerRadius(20, corners: .allCorners)
                }
            }
            .padding(.horizontal, 16.adjustedWidth)
        }
    }
    
    private var information: some View {
        VStack(alignment: .leading, spacing: 8.adjustedHeight) {
            PlaceInformationRow(title: "주소", value: "내용")
            PlaceInformationRow(title: "전화번호", value: "내용")
            PlaceInformationRow(title: "운영시간", value: "내용")
            PlaceInformationRow(title: "바로가기", value: "인스타그램") {
                // TODO: 주소 복사
            }
        }
        .padding(.vertical, 16.adjustedHeight)
        .padding(.horizontal, 20.adjustedWidth)
        .frame(maxWidth: .infinity, alignment: .leading)
        .addBorder(
            .roundedRectangle(cornerRadius: 20),
            borderColor: .gray200,
            borderWidth: 1
        )
        .padding(.horizontal, 16.adjustedWidth)
    }
}
