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
