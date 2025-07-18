//
//  String+.swift
//  Solply
//
//  Created by 김승원 on 7/12/25.
//

import Foundation

extension String {
    func truncated(_ length: Int) -> Self {
        if self.count > length {
            return "\(self.prefix(length)).."
        }
        
        return self
    }
}

extension String {
    func removingTextAfterParenthesis() -> String {
        guard let range = self.range(of: " (") else { return self }
        return String(self[..<range.lowerBound])
    }
}
