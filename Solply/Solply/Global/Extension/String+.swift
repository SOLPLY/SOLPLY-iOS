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
    func truncatedTextAfterParenthesis() -> String {
        guard let range = self.range(of: " (") else { return self }
        return String(self[..<range.lowerBound])
    }
}

extension String {
    func truncatedImageKeyString() -> String {
        guard let devRange = self.range(of: "/dev"),
              let pngRange = self.range(of: ".png", options: .caseInsensitive) else {
            return self
        }
        let startIndex = self.index(after: devRange.lowerBound)
        let endIndex = pngRange.upperBound
        return String(self[startIndex..<endIndex])
    }
}
