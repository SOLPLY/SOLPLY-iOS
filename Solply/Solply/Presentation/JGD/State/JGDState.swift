//
//  JGDState.swift
//  Solply
//
//  Created by 선영주 on 7/15/25.
//

struct JGDState {
    var isCompleteButtonLoading: Bool = false
    
    var initialTownId: Int = 0 // 초기 appState에서 받을 id
    var currentSelectedSubTown: SubTown? = nil // 이전의 선택했던 SubTown을 기억하기 위함
    
    var townList: [Town] = []
    var selectedTown: Town? = nil
    var selectedSubTown: SubTown? = nil
    
    var shouldGoBack: Bool = false
}
