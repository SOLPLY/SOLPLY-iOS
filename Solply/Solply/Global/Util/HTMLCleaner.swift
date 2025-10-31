//
//  HTMLCleaner.swift
//  Solply
//
//  Created by 김승원 on 10/31/25.
//

import Foundation

enum HTMLCleaner {
    static func clean(_ text: String) -> String {
        let cleanedText = cleanHTMLTags(text)
        let decodedText = decodingHTMLEntities(cleanedText)
        return decodedText
    }
}

extension HTMLCleaner {
    /// 모든 HTML 태그(<...>)를 제거합니다.
    private static func cleanHTMLTags(_ text: String) -> String {
        let pattern = "<[^>]+>"
        let cleanedText = text.replacingOccurrences(of: pattern, with: "", options: .regularExpression)
        return cleanedText
    }
    
    /// HTML 엔티티를 디코딩합니다.
    private static func decodingHTMLEntities(_ text: String) -> String {
        guard let data = text.data(using: .utf8) else { return text }
        
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        let decodedText = (try? NSAttributedString(data: data, options: options, documentAttributes: nil).string) ?? text
        return decodedText
    }
}
