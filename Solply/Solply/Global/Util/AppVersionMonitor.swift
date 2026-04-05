//
//  AppVersionMonitor.swift
//  Solply
//
//  Created by 김승원 on 4/5/26.
//

import Foundation

@MainActor @Observable
final class AppVersionMonitor {
    
    // MARK: - Properties
    
    var isUpdateRequired: Bool = false
}

// MARK: - Functions

extension AppVersionMonitor {
    func checkCurrentVersionForUpdate() async {
        let currentVersion = AppEnvironment.currentVersion
        print("🔍 [AppVersionMonitor] 버전 체크 시작 - 현재 버전: \(currentVersion)")
        
        do {
            let latestVersion = try await fetchAppStoreVersion()
            isUpdateRequired = needsUpdate(current: currentVersion, latest: latestVersion)
            print("✅ [AppVersionMonitor] 버전 체크 완료 - 최신 버전: \(latestVersion), 업데이트 필요: \(isUpdateRequired)")
        } catch {
            print("❌ [AppVersionMonitor] 버전 체크 실패: \(error)")
        }
    }
    
    private func fetchAppStoreVersion() async throws -> String {
        let bundleId = AppEnvironment.bundleId
        guard let url = URL(string: "https://itunes.apple.com/lookup?bundleId=\(bundleId)&country=kr") else { return "" }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let result = try JSONDecoder().decode(AppStoreLookupResponse.self, from: data)
        
        guard let version = result.results.first?.version else {
            throw URLError(.badServerResponse)
        }
        
        return version
    }
    
    private func needsUpdate(current: String, latest: String) -> Bool {
        let currentParts = current.split(separator: ".").compactMap { Int($0) }
        let latestParts = latest.split(separator: ".").compactMap { Int($0) }
        
        let maxLength = max(currentParts.count, latestParts.count)
        
        for index in 0..<maxLength {
            let current = index < currentParts.count ? currentParts[index] : 0
            let latest = index < latestParts.count ? latestParts[index] : 0
            if current < latest { return true }
            if current > latest { return false }
        }
        return false
    }
}

// MARK: - Response Model

struct AppStoreLookupResponse: Codable {
    let results: [AppStoreResult]
}

struct AppStoreResult: Codable {
    let version: String
    let trackViewUrl: String
}
