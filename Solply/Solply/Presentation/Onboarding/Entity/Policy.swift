//
//  Policy.swift
//  Solply
//
//  Created by sun on 11/3/25.
//

import Foundation

struct Policy {
    let id: Int
    let title: String
    let content: String
    let isRequired: Bool
    var isAgreed: Bool = false

    let type: PolicyType?

    var url: URL? {
        type?.url
    }

    var showsChevron: Bool {
        type != nil
    }
}
