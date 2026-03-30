//
//  NetworkMonitor.swift
//  Solply
//
//  Created by 김승원 on 3/25/26.
//

import SwiftUI
import Network

@Observable
final class NetworkMonitor {
    
    // MARK: - Properties
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")
    
    private(set) var isConnected: Bool = true
    
    // MARK: - Initializer
    
    init() {
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self else { return }
            
            DispatchQueue.main.async {
                self.isConnected = path.status == .satisfied
            }
        }
        
        monitor.start(queue: queue)
    }
    
    func checkConnection() -> Bool {
        monitor.currentPath.status == .satisfied
    }
    
    deinit {
        monitor.cancel()
    }
}

@Observable
final class RetryRegistry {
    private(set) var reloadID = UUID()
    
    func reload() {
        reloadID = UUID()
    }
}
