//
//  PolicyType.swift
//  Solply
//
//  Created by sun on 12/15/25.
//

import Foundation

enum PolicyType {
    case privacy
    case service
}

extension PolicyType {
    static func from(serverValue: String) -> PolicyType? {
        switch serverValue.uppercased() {
        case "PRIVACY_POLICY":
            return .privacy
        case "SERVICE_POLICY":
            return .service
        default:
            return nil
        }
    }
}

extension PolicyType {

    var url: URL {
        switch self {
        case .privacy:
            return AppEnvironment.privacyPolicyURL
        case .service:
            return AppEnvironment.servicePolicyURL
        }
    }
}
