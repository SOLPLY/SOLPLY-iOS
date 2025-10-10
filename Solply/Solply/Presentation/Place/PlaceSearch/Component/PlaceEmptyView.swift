//
//  PlaceEmptyView.swift
//  Solply
//
//  Created by LEESOOYONG on 9/25/25.
//

import SwiftUI

struct PlaceEmptyView: View {
    
    @EnvironmentObject var appCoordinator: AppCoordinator
    
    var body: some View {
        VStack(alignment: .leading, spacing: 17.5.adjustedHeight) {
            Text("검색 결과가 없어요.\n직접 장소 등록을 솔플리에 요청해보세요.")
                .applySolplyFont(.body_16_r)
                .foregroundColor(.coreBlack)
            
            HStack(alignment: .center, spacing: 0) {
                Text("장소 등록하러 가기")
                    .applySolplyFont(.button_16_m)
                    .foregroundColor(.purple600)
                    
                Image(.arrowRightIconPurple)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24.adjustedWidth, height: 10.adjustedHeight)
            }
            // TODO: - 장소 등록 페이지로 연결
   //        .onTapGesture {
   //            appCoordinator.navigate(to: .)
   //        }
        }
        .padding(.leading, 20.adjustedWidth)
    }
}
