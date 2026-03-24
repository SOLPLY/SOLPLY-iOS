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
    
    private let networkMonitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")
    private(set) var isConnected: Bool = false
    
    
    // MARK: - Initializer
    
    init() {
        networkMonitor.pathUpdateHandler = { [weak self] path in
            guard let self else { return }
            
            self.isConnected = path.status == .satisfied
        }
        
        networkMonitor.start(queue: queue)
    }
    
    deinit {
        networkMonitor.cancel()
    }
}
