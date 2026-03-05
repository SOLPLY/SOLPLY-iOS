//
//  PlaceEmptyView.swift
//  Solply
//
//  Created by LEESOOYONG on 9/25/25.
//

import SwiftUI

struct PlaceEmptyView: View {
    
    // MARK: - Properties
    
    private let registerAction: (() -> Void)?
    
    // MARK: - Initializer
    
    init(registerAction: (() -> Void)? = nil) {
        self.registerAction = registerAction
    }
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .leading, spacing: 17.5.adjustedHeight) {
            Text("검색 결과가 없어요.\n직접 장소 등록을 솔플리에 요청해보세요.")
                .applySolplyFont(.body_16_r)
                .foregroundColor(.coreBlack)
            
            Button {
                registerAction?()
            } label: {
                HStack(alignment: .center, spacing: 0) {
                    Text("장소 등록하러 가기")
                        .applySolplyFont(.button_16_m)
                        .foregroundColor(.purple600)
                        
                    Image(.arrowRightIconPurple)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24.adjustedWidth, height: 10.adjustedHeight)
                }
            }
            .buttonStyle(.plain)
        }
        .padding(.leading, 20.adjustedWidth)
    }
}
