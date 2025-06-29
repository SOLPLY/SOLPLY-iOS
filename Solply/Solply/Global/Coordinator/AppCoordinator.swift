//
//  AppCoordinator.swift
//  Solply
//
//  Created by 김승원 on 6/28/25.
//

import Foundation

final class AppCoordinator: ObservableObject {
    
    // MARK: - Properties
    
    @Published var path: [AppDestination] = []
    @Published var root: RootDestination = .auth
    @Published var selectedTab: TabBarState = .place
    
    // MARK: - Functions
    
    func navigate(to destination: AppDestination) {
        path.append(destination)
    }
    
    func goBack() {
        _ = path.popLast()
    }
    
    func goToRoot() {
        path.removeAll()
    }
    
    func switchTab(to tab: TabBarState) {
        selectedTab = tab
    }
    
    func changeRoot(to root: RootDestination) {
        self.root = root
    }
}
