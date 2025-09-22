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
        VStack(alignment: .center, spacing: 0) {
            SearchBarView(onChange: onChange, onSubmit: onSubmit)
            // TODO: - 데이터 유무로 분기처리
        }
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
