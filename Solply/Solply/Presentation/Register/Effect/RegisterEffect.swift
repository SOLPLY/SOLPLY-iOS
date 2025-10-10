//
//  RegisterEffect.swift
//  Solply
//
//  Created by 김승원 on 10/10/25.
//

import Foundation

struct RegisterEffect {
    private let tagsService: TagsAPI
    
    init(tagsService: TagsAPI) {
        self.tagsService = tagsService
    }
}

// MARK: - TagsAPI

extension RegisterEffect {
    func fetchSubTags(parentId: Int) async -> RegisterAction {
        do {
            let response = try await tagsService.fetchSubTags(parentId: parentId)
            
            guard let data = response.data?.tags else {
                return .errorOccured(error: .responseError)
            }
            
            let subTags = data.map { subTagDTO in
                SubTag(dto: subTagDTO)
            }
            
            let selectableTags = subTags.map { dto in
                SelectableSubTag(from: dto)
            }
            
            return .subTagsFetched(selectableSubTags: selectableTags)
        } catch let error as NetworkError {
            return .errorOccured(error: error)
        } catch {
            return .errorOccured(error: .unknownError)
        }
    }
}
