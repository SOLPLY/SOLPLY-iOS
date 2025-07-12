//
//  ArchiveListState.swift
//  Solply
//
//  Created by LEESOOYONG on 7/10/25.
//

import Foundation

struct ArchiveListState {
    var selectedIndex: Set<Int> = []
    var activeDelete: Bool = false
    var activeCancel: Bool = false
    
    var isPresented: Bool = false
}
