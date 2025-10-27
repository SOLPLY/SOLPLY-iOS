//
//  TownListResponseDTO.swift
//  Solply
//
//  Created by sun on 8/26/25.
//

import Foundation

struct TownDTO: Decodable {
    let townId: Int
    let townName: String
    let parentTownId: Int?
    
    var id: Int { townId }
}

struct TownListResponseDTO: ResponseModelType {
    let towns: [TownDTO]
    
    func toEntity() -> [Town] {
        let parentTowns = towns.filter { town in
            return town.parentTownId == nil
        }

        var structuredTownList: [Town] = []

        for parent in parentTowns {
            var subTownList: [SubTown] = []

            for child in towns {
                if child.parentTownId == parent.townId {
                    let subTown = SubTown(
                        id: child.townId,
                        townName: child.townName
                    )
                    subTownList.append(subTown)
                }
            }

            let town = Town(
                id: parent.townId,
                townName: parent.townName,
                subTowns: subTownList
            )
            
            structuredTownList.append(town)
        }

        return structuredTownList
    }
}

