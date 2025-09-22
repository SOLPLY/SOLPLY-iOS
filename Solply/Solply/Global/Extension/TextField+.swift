//
//  TextField+.swift
//  Solply
//
//  Created by 김승원 on 9/22/25.
//

import SwiftUI

extension TextField {
    func configureDefaultTextField() -> some View {
        self
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled(true)
    }
}
