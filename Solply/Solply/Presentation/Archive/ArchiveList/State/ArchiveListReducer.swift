//
//  ArchiveListReducer.swift
//  Solply
//
//  Created by LEESOOYONG on 7/10/25.
//

import Foundation

enum ArchiveListReducer {
    static func reduce(state: inout ArchiveListState, action: ArchiveListAction) {
        switch action {
        case .toggleArchiveList(let index):
            if state.selectedIndex.contains(index) {
                state.selectedIndex.remove(index)
            } else {
                state.selectedIndex.insert(index)
            }
            
        case .toggleSelect:
            state.activeDelete = true
            
        case .toggleCancel:
            state.selectedIndex.removeAll()
            state.activeDelete = false
            
        case .showAlert:
            state.isPresented = true
            
        case .alertCancel:
            state.isPresented = false
            
        case .alertDelete:
            state.isPresented = false
            state.activeDelete = false
            print("삭제 API 연결")
            
        case .fetchCourseList:
            break
            
        case .courseListFetched(let courseLists):
            state.courses = courseLists
            print(courseLists)
            
        case .errorOccured(let error):
            print(error)
            break
        }
    }
}
