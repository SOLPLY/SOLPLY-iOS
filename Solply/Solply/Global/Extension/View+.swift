//
//  View+.swift
//  Solply
//
//  Created by 김승원 on 6/27/25.
//

import SwiftUI

extension View {
    /// 현재 화면에서 키보드를 내립니다.
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
