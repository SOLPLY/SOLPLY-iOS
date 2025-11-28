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
    @Published var root: RootDestination = .splash
    @Published var selectedTab: TabBarState = .place
    
    private var tokenExpiredObserver: NSObjectProtocol?
    
    // MARK: - Initializer
    
    init() {
        observeTokenExpired()
    }
    
    deinit {
        if let tokenExpiredObserver {
            NotificationCenter.default.removeObserver(tokenExpiredObserver)
        }
    }
    
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
        path.removeAll()
    }
    
    // MARK: - Private
    
    private func observeTokenExpired() {
        tokenExpiredObserver = NotificationCenter.default.addObserver(
            forName: .tokenExpired,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            guard let self else { return }
            
            self.changeRoot(to: .auth)
        }
    }
}
