//
//  AmplitudeManager.swift
//  Solply
//
//  Created by 김승원 on 1/20/26.
//

import Foundation

import AmplitudeSwift

final class AmplitudeManager {
    
    // MARK: - Singleton
    
    static let shared = AmplitudeManager()
    private init() {}
    
    // MARK: - Properties
    
    private let queue = DispatchQueue(label: "amplitude.manager.queue")
    private var client: Amplitude?
    private var isInitialized = false
    
    // MARK: - Initialize
    
    func start(apiKey: String) {
        guard !isInitialized else { return }
        
        let configuration = Configuration(
            apiKey: apiKey,
            autocapture: [.sessions, .appLifecycles]
        )
        
#if DEBUG
        configuration.logLevel = .DEBUG
#else
        configuration.logLevel = .WARN
#endif
        
        queue.sync {
            self.client = Amplitude(configuration: configuration)
            self.isInitialized = true
        }
        
        log("Initialized")
        log("AutoCapture enabled: \(configuration.autocapture)")
    }
    
    // MARK: - Track
    
    func track(_ event: AmplitudeTrackable) {
        queue.async { [weak self] in
            guard let self,
                  let client = self.client else { return }
            
            client.track(
                eventType: event.name,
                eventProperties: event.properties
            )
            
            log(
                name: event.name,
                properties: event.properties
            )
        }
    }
    
    // MARK: - Bind User
    
    func bindUser(_ id: String?) {
        queue.async { [weak self] in
            self?.client?.setUserId(userId: id)
        }
    }
    
    // MARK: - reset
    
    func reset() {
        queue.async { [weak self] in
            self?.client?.reset()
        }
    }
}

// MARK: - Logger

extension AmplitudeManager {
    private func log(_ message: String) {
        #if DEBUG
        print("📊 [Amplitude] \(message)")
        #endif
    }

    private func log(
        name: String,
        properties: [String: Any]?
    ) {
        #if DEBUG
        if let properties {
            print("📊 [Amplitude] Event: \(name)")
            print("               Properties: \(properties)")
        } else {
            print("📊 [Amplitude] Event: \(name)")
        }
        #endif
    }
}
