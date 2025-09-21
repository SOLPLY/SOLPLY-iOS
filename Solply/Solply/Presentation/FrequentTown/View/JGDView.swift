//
//  JGDView.swift
//  Solply
//
//  Created by seozero on 9/11/25.
//

import SwiftUI

struct JGDView: View {
    
    @EnvironmentObject private var appCoordinator: AppCoordinator
    @ObservedObject var store = FrequentTownStore()
    
    @State private var selectedCity: String? = "서울"
    @State private var selectedTown: String? = nil
    
    // TODO: - API 연결해보기
    var cityList: [String] = ["서울", "경기", "인천", "부산", "대구"]
    var townList: [String] = ["망원동", "연희동", "성수동", "한남동"]
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(alignment: .center, spacing: 0) {
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(.gray300)
                HStack(alignment: .top, spacing: 0) {
                    VStack(alignment: .center, spacing: 0) {
                        VStack(alignment: .center, spacing: 0) {
                            ForEach(cityList, id: \.self) { city in
                                JGDCityRow(
                                    selectedCity: $selectedCity,
                                    selectedTown: $selectedTown,
                                    city: city
                                )
                            }
                        }
                        
                        Spacer()
                    }
                    .frame(maxHeight: .infinity)
                    .background(.gray100)
                    
                    Divider()
                    
                    VStack(alignment: .center, spacing: 0) {
                        ForEach(townList, id: \.self) { town in
                            JGDTownRow(selectedTown: $selectedTown, town: town)
                        }
                    }
                    .frame(width: 247.adjustedWidth)
                }
            }
            .customNavigationBar(
                .frequentTown(backAction: appCoordinator.goBack)
            )
            
            CTAMainButton(title: "완료")
                .padding(.horizontal, 20)
                .padding(.bottom, 16)
        }
    }
}

#Preview {
    JGDView()
        .environmentObject(AppCoordinator())
}
