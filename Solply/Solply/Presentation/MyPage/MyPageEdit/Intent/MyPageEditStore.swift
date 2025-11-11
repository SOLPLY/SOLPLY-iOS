//
//  MyPageEditStore.swift
//  Solply
//
//  Created by sun on 9/26/25.
//

import Foundation

@MainActor
final class MyPageEditStore: ObservableObject {
    
    // MARK: - Properites
    
    @Published private(set) var state = MyPageEditState()
    
    let userInformation: UserInformation
    let profileImageUrl: String
    
    // MARK: - Initializer
    
    init(userInformation: UserInformation, profileImageUrl: String) {
        self.userInformation = userInformation
        self.profileImageUrl = profileImageUrl
    }
    
    // MARK: - Dispatch
    
    func dispatch(_ action: MyPageEditAction) {
        MyPageEditReducer.reduce(state: &state, action: action)
        
        switch action {
        default:
            break
        }
    }
}
