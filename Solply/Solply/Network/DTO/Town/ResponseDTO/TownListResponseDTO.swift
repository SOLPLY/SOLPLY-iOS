//
//  TownListResponseDTO.swift
//  Solply
//
//  Created by sun on 8/26/25.
//

import Foundation

struct TownDTO: ResponseModelType {
    let townId: Int
    let townName: String
    let parentTownId: Int?
    
    var id: Int { townId }
}

struct TownListResponseDTO: ResponseModelType {
    let towns: [TownDTO]
    
    func toEntity(includeAllOption: Bool = false) -> [Town] {
        let childrenByParentId = Dictionary(grouping: towns) { $0.parentTownId }
        
        let parentTowns = towns.filter { $0.parentTownId == nil }
        
        return parentTowns.map { parent in
            let childSubTowns = (childrenByParentId[parent.townId] ?? []).map { child in
                SubTown(id: child.townId, townName: child.townName)
            }
            
            let subTowns: [SubTown]
            if includeAllOption {
                let allSubTown = SubTown(id: parent.townId, townName: "전체")
                subTowns = [allSubTown] + childSubTowns
            } else {
                subTowns = childSubTowns
            }
            
            return Town(
                id: parent.townId,
                townName: parent.townName,
                subTowns: subTowns
            )
        }
    }
}

