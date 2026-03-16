//
//  Record.swift
//  Solply
//
//  Created by 김승원 on 3/14/26.
//

import Foundation

struct Record: Identifiable {
    let id = UUID()
    let profileImageUrl: String?
    let userName: String
    let photoUrls: [String]
    let recordText: String
    let visitTime: String
}

extension Record {
    static var mock: [Record] {
        return [
            Record(
                profileImageUrl: "https://i.pinimg.com/1200x/23/ce/ea/23ceead7c9d0d5db016b404faa3bbd87.jpg",
                userName: "민지",
                photoUrls: [
                    "https://search.pstatic.net/sunny/?src=https%3A%2F%2Fi.pinimg.com%2F736x%2F9f%2Fb0%2F61%2F9fb06135b344f36d398e0ba51cf14841.jpg&type=sc960_832",
                    "https://search.pstatic.net/sunny/?src=https%3A%2F%2Fi.pinimg.com%2F736x%2F9f%2Fb0%2F61%2F9fb06135b344f36d398e0ba51cf14841.jpg&type=sc960_832",
                    "https://search.pstatic.net/sunny/?src=https%3A%2F%2Fi.pinimg.com%2F736x%2F9f%2Fb0%2F61%2F9fb06135b344f36d398e0ba51cf14841.jpg&type=sc960_832",
                    "https://search.pstatic.net/sunny/?src=https%3A%2F%2Fi.pinimg.com%2F736x%2F9f%2Fb0%2F61%2F9fb06135b344f36d398e0ba51cf14841.jpg&type=sc960_832",
                    "https://search.pstatic.net/sunny/?src=https%3A%2F%2Fi.pinimg.com%2F736x%2F9f%2Fb0%2F61%2F9fb06135b344f36d398e0ba51cf14841.jpg&type=sc960_832"
                ],
                recordText: "주말 오후에 방문했는데 사람이 많지 않아서 좋았어요. 창가 자리에서 노트북 작업하기 딱 좋았습니다. 음료도 맛있고 분위기도 차분해서 집중이 잘 됐어요.",
                visitTime: "2026.02.19 오후 방문"
            ),
            Record(
                profileImageUrl: nil,
                userName: "승원",
                photoUrls: [
                    "https://search.pstatic.net/sunny/?src=https%3A%2F%2Fi.pinimg.com%2F736x%2F9f%2Fb0%2F61%2F9fb06135b344f36d398e0ba51cf14841.jpg&type=sc960_832",
                    "https://search.pstatic.net/sunny/?src=https%3A%2F%2Fi.pinimg.com%2F736x%2F9f%2Fb0%2F61%2F9fb06135b344f36d398e0ba51cf14841.jpg&type=sc960_832"
                ],
                recordText: "주말 오후에 방문했는데 사람이 많지 않아서 좋았어요. 창가 자리에서 노트북 작업하기 딱 좋았습니다. 음료도 맛있고 분위기도 차분해서 집중이 잘 됐어요.",
                visitTime: "2026.02.19 오후 방문"
            ),
            Record(
                profileImageUrl: "https://i.pinimg.com/1200x/23/ce/ea/23ceead7c9d0d5db016b404faa3bbd87.jpg",
                userName: "솔플릴",
                photoUrls: [],
                recordText: "주말 오후에 방문했는데 사람이 많지 않아서 좋았어요. 창가 자리에서 노트북 작업하기 딱 좋았습니다. 음료도 맛있고 분위기도 차분해서 집중이 잘 됐어요.",
                visitTime: "2026.02.19 오후 방문"
            ),
            Record(
                profileImageUrl: "https://i.pinimg.com/1200x/23/ce/ea/23ceead7c9d0d5db016b404faa3bbd87.jpg",
                userName: "민지",
                photoUrls: [
                    "https://search.pstatic.net/sunny/?src=https%3A%2F%2Fi.pinimg.com%2F736x%2F9f%2Fb0%2F61%2F9fb06135b344f36d398e0ba51cf14841.jpg&type=sc960_832",
                    "https://search.pstatic.net/sunny/?src=https%3A%2F%2Fi.pinimg.com%2F736x%2F9f%2Fb0%2F61%2F9fb06135b344f36d398e0ba51cf14841.jpg&type=sc960_832",
                    "https://search.pstatic.net/sunny/?src=https%3A%2F%2Fi.pinimg.com%2F736x%2F9f%2Fb0%2F61%2F9fb06135b344f36d398e0ba51cf14841.jpg&type=sc960_832",
                    "https://search.pstatic.net/sunny/?src=https%3A%2F%2Fi.pinimg.com%2F736x%2F9f%2Fb0%2F61%2F9fb06135b344f36d398e0ba51cf14841.jpg&type=sc960_832",
                    "https://search.pstatic.net/sunny/?src=https%3A%2F%2Fi.pinimg.com%2F736x%2F9f%2Fb0%2F61%2F9fb06135b344f36d398e0ba51cf14841.jpg&type=sc960_832"
                ],
                recordText: "주말 오후에 방문했는데 사람이 많지 않아서 좋았어요. 창가 자리에서 노트북 작업하기 딱 좋았습니다. 음료도 맛있고 분위기도 차분해서 집중이 잘 됐어요.",
                visitTime: "2026.02.19 오후 방문"
            ),
            Record(
                profileImageUrl: "https://i.pinimg.com/1200x/23/ce/ea/23ceead7c9d0d5db016b404faa3bbd87.jpg",
                userName: "민지",
                photoUrls: [
                    "https://search.pstatic.net/sunny/?src=https%3A%2F%2Fi.pinimg.com%2F736x%2F9f%2Fb0%2F61%2F9fb06135b344f36d398e0ba51cf14841.jpg&type=sc960_832",
                    "https://search.pstatic.net/sunny/?src=https%3A%2F%2Fi.pinimg.com%2F736x%2F9f%2Fb0%2F61%2F9fb06135b344f36d398e0ba51cf14841.jpg&type=sc960_832",
                    "https://search.pstatic.net/sunny/?src=https%3A%2F%2Fi.pinimg.com%2F736x%2F9f%2Fb0%2F61%2F9fb06135b344f36d398e0ba51cf14841.jpg&type=sc960_832",
                    "https://search.pstatic.net/sunny/?src=https%3A%2F%2Fi.pinimg.com%2F736x%2F9f%2Fb0%2F61%2F9fb06135b344f36d398e0ba51cf14841.jpg&type=sc960_832",
                    "https://search.pstatic.net/sunny/?src=https%3A%2F%2Fi.pinimg.com%2F736x%2F9f%2Fb0%2F61%2F9fb06135b344f36d398e0ba51cf14841.jpg&type=sc960_832"
                ],
                recordText: "주말 오후에 방문했는데 사람이 많지 않아서 좋았어요. 창가 자리에서 노트북 작업하기 딱 좋았습니다. 음료도 맛있고 분위기도 차분해서 집중이 잘 됐어요.",
                visitTime: "2026.02.19 오후 방문"
            )
        ]
    }
}
