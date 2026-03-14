//
//  RecordListReducer.swift
//  Solply
//
//  Created by 김승원 on 3/14/26.
//

import Foundation

enum RecordListReducer {
    static func reduce(state: inout RecordListState, action: RecordListAction) {
        switch action {
        case .onAppear:
            state.records = Record.mock
        }
    }
}
