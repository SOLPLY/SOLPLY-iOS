//
//  MySolplyRecord.swift
//  Solply
//
//  Created by 김승원 on 4/17/26.
//

import Foundation

struct MySolplyRecord: Identifiable {
    let id: Int
    let placeTagType: MainTagType
    let placeId: Int
    let placeName: String
    let PhotosUrls: [String]
    let recordText: String
    let visitTime: String
}

extension MySolplyRecord {
    static var mock: [MySolplyRecord] {
        return [
            MySolplyRecord(
                id: 1,
                placeTagType: .book,
                placeId: 1,
                placeName: "임시장소1",
                PhotosUrls: [
                    "https://i.pinimg.com/1200x/23/ce/ea/23ceead7c9d0d5db016b404faa3bbd87.jpg",
                    "https://i.pinimg.com/1200x/23/ce/ea/23ceead7c9d0d5db016b404faa3bbd87.jpg",
                    "https://i.pinimg.com/1200x/23/ce/ea/23ceead7c9d0d5db016b404faa3bbd87.jpg",
                    "https://i.pinimg.com/1200x/23/ce/ea/23ceead7c9d0d5db016b404faa3bbd87.jpg",
                    "https://i.pinimg.com/1200x/23/ce/ea/23ceead7c9d0d5db016b404faa3bbd87.jpg"
                ],
                recordText: "주말 오후에 방문했는데 사람이 많지 않아서 좋았어요. 창가 자리에서 노트북 작업하기 딱 좋았습니다. 음료도 맛있고 분위기도 차분해서 집중이 잘 됐어요.",
                visitTime: "2026.02.19 오후 방문"
            ),
            MySolplyRecord(
                id: 2,
                placeTagType: .food,
                placeId: 2,
                placeName: "임시장소2",
                PhotosUrls: [],
                recordText: "주말 오후에 방문했는데 사람이 많지 않아서 좋았어요. 창가 자리에서 노트북 작업하기 딱 좋았습니다. 음료도 맛있고 분위기도 차분해서 집중이 잘 됐어요.",
                visitTime: "2026.02.19 오후 방문"
            ),
            MySolplyRecord(
                id: 3,
                placeTagType: .walk,
                placeId: 3,
                placeName: "임시장소3",
                PhotosUrls: [
                    "https://i.pinimg.com/1200x/23/ce/ea/23ceead7c9d0d5db016b404faa3bbd87.jpg",
                    "https://i.pinimg.com/1200x/23/ce/ea/23ceead7c9d0d5db016b404faa3bbd87.jpg"
                ],
                recordText: "주말 오후에 방문했는데 사람이 많지 않아서 좋았어요. 창가 자리에서 노트북 작업하기 딱 좋았습니다. 음료도 맛있고 분위기도 차분해서 집중이 잘 됐어요.",
                visitTime: "2026.02.19 오후 방문"
            )
        ]
    }
}
