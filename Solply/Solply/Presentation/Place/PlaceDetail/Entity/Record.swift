//
//  Record.swift
//  Solply
//
//  Created by 김승원 on 3/14/26.
//

import Foundation

struct Record: Identifiable {
    let id: Int
    let userId: Int
    let profileImageUrl: String?
    let userName: String
    let photoUrls: [String]
    let recordText: String
    let visitTime: String
}

extension Record {
    init(_ reviewDto: ReviewDTO) {
        self.id = reviewDto.reviewId
        self.userId = reviewDto.userId
        self.profileImageUrl = reviewDto.profileImageUrl
        self.userName = reviewDto.nickname
        self.photoUrls = reviewDto.imageUrls
        self.recordText = reviewDto.content
        self.visitTime = "\(reviewDto.visitedAt.replacingOccurrences(of: "-", with: ".")) \(reviewDto.visitTimeSlot.title) 방문"
    }
}

extension Record {
    static var mock: [Record] {
        return [
            Record(
                id: 1,
                userId: 1,
                profileImageUrl: "https://i.pinimg.com/1200x/23/ce/ea/23ceead7c9d0d5db016b404faa3bbd87.jpg",
                userName: "민지",
                photoUrls: [
                    "https://search.pstatic.net/sunny/?src=https%3A%2F%2Fi.pinimg.com%2F736x%2F9f%2Fb0%2F61%2F9fb06135b344f36d398e0ba51cf14841.jpg&type=sc960_832",
                    "https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyNTA5MTFfMTU3%2FMDAxNzU3NTgxMDg3NTk2.y_DL7MMExP9nM7aMB2BgWynCkIydYqFsRL4ASgh5l1cg.LIX752CK1RVpzLFqgJ8SbYDV5nw4YvKAcr9IBGzmDz0g.JPEG%2FR0006165.jpg&type=sc960_832",
                    "https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyNTA1MDlfMjAw%2FMDAxNzQ2NzY3ODExODE1.W6vHjpQLrfCRzF62e37BEIgM6aJN4cVNtWNqYrIaiSwg.X-9Y1KS5rN2q14yDwYyveIgeigRVDLW_T0GpuPez4EEg.JPEG%2FIMG_2792.JPG&type=sc960_832",
                    "https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyNTA1MzBfNzAg%2FMDAxNzQ4NTg4NTIzMzI0.KahfSQ3JyVQL0692o3Wj1Tan9WOd14nz250c5VidHbwg.ssFvb2KdTymFZFeK-IwgG2XIx_ikO5UrHuNZPH6qKR0g.JPEG%2F40.JPG&type=sc960_832",
                    "https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyNTExMTVfMjQg%2FMDAxNzYzMTY4ODQ5MzIw.d6AUryIHVWy6O8TkhOuxGgrshd4l2CpEfXXkI6r4zrEg.ixcZsCeZAQ9CxWOLKwrUF4_HRod2c6xiWwsVJmHuevUg.JPEG%2FIMG_9247.jpeg&type=sc960_832"
                ],
                recordText: "주말 오후에 방문했는데 사람이 많지 않아서 좋았어요. 창가 자리에서 노트북 작업하기 딱 좋았습니다. 음료도 맛있고 분위기도 차분해서 집중이 잘 됐어요.",
                visitTime: "2026.02.19 오후 방문"
            ),
            Record(
                id: 2,
                userId: 2,
                profileImageUrl: nil,
                userName: "승원",
                photoUrls: [
                    "https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyNTA2MDFfODgg%2FMDAxNzQ4NzU2ODg4MjIw.g94uxcGC4HL64zq1s22fi2gq-xzzZtxLxXbwxpjiRSwg.2SzUjkWMPwE-BnZmcRN4OQV-yeGrkQlwisRT6EAJnpgg.JPEG%2F6_%25C5%25A5%25C7%25C3%25B7%25B9%25C0%25CC%25BD%25BA.JPG&type=sc960_832",
                    "https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyNjAxMjdfMjkx%2FMDAxNzY5NDg1NDA2OTA5.d3aEzeXZ5uIn_cnBtOQn1DnLrEU7_l-QhqEuJSgqKPcg.ZZTYc2goo0DdhNRzSdT4RmMQUTdR5jE3TLPIlEpPcGcg.JPEG%2F900%25A3%25DF1769485406212.jpg&type=sc960_832"
                ],
                recordText: "주말 오후에 방문했는데 사람이 많지 않아서 좋았어요. 창가 자리에서 노트북 작업하기 딱 좋았습니다. 음료도 맛있고 분위기도 차분해서 집중이 잘 됐어요.",
                visitTime: "2026.02.19 오후 방문"
            ),
            Record(
                id: 3,
                userId: 3,
                profileImageUrl: "https://i.pinimg.com/1200x/23/ce/ea/23ceead7c9d0d5db016b404faa3bbd87.jpg",
                userName: "솔플릴",
                photoUrls: [],
                recordText: "주말 오후에 방문했는데 사람이 많지 않아서 좋았어요. 창가 자리에서 노트북 작업하기 딱 좋았습니다. 음료도 맛있고 분위기도 차분해서 집중이 잘 됐어요.",
                visitTime: "2026.02.19 오후 방문"
            ),
            Record(
                id: 4,
                userId: 4,
                profileImageUrl: "https://i.pinimg.com/1200x/23/ce/ea/23ceead7c9d0d5db016b404faa3bbd87.jpg",
                userName: "민지",
                photoUrls: [
                    "https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyNTA2MTZfMTYg%2FMDAxNzUwMDQ3NjczNTYz.zDY4U460W6yVT8Fuzx4QSl0sHpKd5Pbigg_erM56Ee4g.rpXonK98zVIfcuR6nY83KzUMpV2hC0blckbhgPFVCMAg.JPEG%2FIMG%25A3%25DF5639.jpg&type=sc960_832",
                    "https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyNTExMTVfNTYg%2FMDAxNzYzMjE3MDA3ODQ3.hp_Uhe_cjRQ1qw0eTVC4g89Ji1mcsjq11BCU4IV6XRsg.Mge1fMJaB00HOTpOmS5oVXSWpamZvZ9j0IS3o_8rJZEg.JPEG%2FIMG%25A3%25DF7484.JPG&type=sc960_832",
                    "https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyNTA1MDVfNzYg%2FMDAxNzQ2NDM1NzI4OTA3.kkYeYbbAfwPb2FrnWuJddyOiMq9d3-kdgZxgNrQZnQog.LScgMDsMsiNj-pQwgkvcUoB1fylcV2kcu1SvtoUku8Ug.JPEG%2FIMG_5544.jpg&type=sc960_832",
                    "https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyNTEwMTNfNzIg%2FMDAxNzYwMzIzNjg0MDA4.sFXazs3p_33ogc249KQVeofmMoRvhj8hyT92M6kthDMg.4aQ0u5W-cnlBJu29_iJdfbrUM6UZF3c1cqgmr2qn2kgg.JPEG%2FIMG%25A3%25DF6660.jpg&type=sc960_832"
                ],
                recordText: "주말 오후에 방문했는데 사람이 많지 않아서 좋았어요. 창가 자리에서 노트북 작업하기 딱 좋았습니다. 음료도 맛있고 분위기도 차분해서 집중이 잘 됐어요.",
                visitTime: "2026.02.19 오후 방문"
            ),
            Record(
                id: 5,
                userId: 5,
                profileImageUrl: "https://i.pinimg.com/1200x/23/ce/ea/23ceead7c9d0d5db016b404faa3bbd87.jpg",
                userName: "민지",
                photoUrls: [
                    "https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyNTA5MDlfMjY3%2FMDAxNzU3Mzk1ODIzOTk1.ZN-7hbjL6TTP-xD0CZ_MoWOltwLKwKlokNv3IwKWt8gg.8c0c9Cr0Qy2yGvIMVpOQ5UgTucwbpnizFth_yfvgC1og.JPEG%2FDSCF1355.JPG&type=sc960_832",
                    "https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyNTA5MDhfMTkx%2FMDAxNzU3MzIzMTI3OTE0.NiKuuJxjy_NcISIEoDuwJOgFNK3BcOgmO4SSM92YkBog.8mf4UMVcLQQscIe33n6jatEwlwoSY8y33I1N-DvXe5gg.JPEG%2F%25C4%25AB%25C6%25E4_%252832%2529.jpg&type=sc960_832",
                    "https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyNTExMTNfNyAg%2FMDAxNzYzMDM3NzQ1NDYx.TsKYnoJLmXe26sL8ecdWUKxAlLk7l-ovU2iL0YK4N8og.qSyImB7hZQ9tkGsEwjmdVg1O8EpmxAdd-4gfLxg1D8wg.JPEG%2F20251104_141354.jpg&type=sc960_832",
                    "https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyNTA2MTlfOTQg%2FMDAxNzUwMjkwNTAyNTQ5.B6lJ2bHm4yM_Qz2pFZ6kYwooSsELptOAICihU_s9MUcg.PcrusdHIFrauYCKndZJvP08e4gN0mdZbK5GfnTeiB3Ug.PNG%2F%25BD%25BA%25C5%25A9%25B8%25B0%25BC%25A6_2025-06-19_%25BF%25C0%25C0%25FC_8.48.19.png&type=sc960_832",
                    "https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyNTA2MjFfMjQy%2FMDAxNzUwNDcxODc1MDgw.eY7Uhw2VCUtRGO3XszWsyVQeb5ZsL-DoSopBpLkK3U4g.v7ATnMCs3IVPC81VgUgumXy5akvJSzttT76ijI8-7oog.JPEG%2FIMG%25A3%25DF1199.jpg&type=sc960_832"
                ],
                recordText: "주말 오후에 방문했는데 사람이 많지 않아서 좋았어요. 창가 자리에서 노트북 작업하기 딱 좋았습니다. 음료도 맛있고 분위기도 차분해서 집중이 잘 됐어요.",
                visitTime: "2026.02.19 오후 방문"
            )
        ]
    }
}
