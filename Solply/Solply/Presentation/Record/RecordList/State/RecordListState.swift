//
//  RecordListState.swift
//  Solply
//
//  Created by 김승원 on 3/14/26.
//

import Foundation

struct RecordListState {
    var records: [Record] = []
    
    var selectedImageViewerIndex: Int? = nil
    var selectedImageViewerUrls: [String?] = []
}
