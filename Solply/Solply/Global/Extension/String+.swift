//
//  String+.swift
//  Solply
//
//  Created by 김승원 on 7/12/25.
//

import Foundation

extension String {
    /// 문자열을 지정한 길이를 기준으로 잘라낸 새로운 문자열을 반환합니다.
    /// - Parameter length: 남기고자 하는 최대 글자 수. 문자열이 이 값을 초과하면 잘라냅니다.
    /// - Returns: 지정한 길이로 잘라낸 문자열. 잘림이 발생하면 문자열 끝에 ".."가 붙습니다.
    func truncated(length: Int) -> Self {
        if self.count > length {
            return "\(self.prefix(length)).."
        }
        
        return self
    }
    
    /// 문자열을 지정한 문자열 이전까지 잘라낸 새로운 문자열을 반환합니다.
    /// - Parameter excludeEndRange: 이 문자열 직전까지만 남기고 잘라낼 기준 문자열.
    /// - Returns: 기준 문자열 직전까지의 부분 문자열.
    func truncated(excludeEndRange: String) -> String {
        guard let endRange = self.range(of: excludeEndRange) else { return self }
        
        return String(self[..<endRange.lowerBound])
    }
    
    /// 문자열을 지정한 시작 문자열 이후부터 끝 문자열 직전까지 잘라낸 새로운 문자열을 반환합니다.
    /// - Parameters:
    ///   - includeStartRange: 시작 기준 문자열. 이 문자열 직후부터 포함됩니다.
    ///   - excludeEndRange: 끝 기준 문자열. 이 문자열 직전까지만 포함됩니다.
    /// - Returns: 시작과 끝 기준 문자열 사이의 부분 문자열.
    func truncated(includeStartRange: String, excludeEndRange: String) -> String {
        guard let startRange = self.range(of: includeStartRange),
              let endRange = self.range(of: excludeEndRange) else { return self }
        
        return String(self[startRange.lowerBound..<endRange.lowerBound])
    }
    
    func truncatedForS3() -> String {
    #if DEBUG
        return truncated(includeStartRange: "dev", excludeEndRange: "?")
    #else
        return truncated(includeStartRange: "prod", excludeEndRange: "?")
    #endif
    }
}
