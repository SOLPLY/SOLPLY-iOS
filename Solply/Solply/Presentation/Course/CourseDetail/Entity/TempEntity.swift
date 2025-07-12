//
//  TempEntity.swift
//  Solply
//
//  Created by 김승원 on 7/11/25.
//

import Foundation

struct Course {
    let courseTitle: String
    let courseDescription: String
    var places: [Place]
    
    static func mockData() -> Course {
        return Course(
            courseTitle: "오감으로 수집하는 하루우우우우우우우우우우우우우우우우우우우우우",
            courseDescription: "귀여운 당고 디저트와 커피, 에이드가 있는 펫 프렌들리 코스",
            places: [
                Place(
                    imageURL: "",
                    latitude: 37.5694,
                    longitude: 126.9246,
                    isFocused: false,
                    isSaved: true,
                    placeCategoryType: .book,
                    title: "장소 이름응응응믕믕믕믕믕응으으으으",
                    address: "상세주소오오오오오오오오오오오오오"
                ),
                Place(
                    imageURL: "",
                    latitude: 37.5689,
                    longitude: 126.9239,
                    isFocused: false,
                    isSaved: false,
                    placeCategoryType: .unique,
                    title: "장소 이름",
                    address: "상세주소"
                ),
                Place(
                    imageURL: "",
                    latitude: 37.5702,
                    longitude: 126.9253,
                    isFocused: false,
                    isSaved: true,
                    placeCategoryType: .cafe,
                    title: "장소 이름",
                    address: "상세주소"
                ),
                Place(
                    imageURL: "",
                    latitude: 37.5697,
                    longitude: 126.9260,
                    isFocused: false,
                    isSaved: false,
                    placeCategoryType: .food,
                    title: "장소 이름",
                    address: "상세주소"
                ),
                Place(
                    imageURL: "",
                    latitude: 37.5685,
                    longitude: 126.9235,
                    isFocused: false,
                    isSaved: false,
                    placeCategoryType: .shopping,
                    title: "장소 이름",
                    address: "상세주소"
                ),
                Place(
                    imageURL: "",
                    latitude: 37.5699,
                    longitude: 126.9248,
                    isFocused: false,
                    isSaved: false,
                    placeCategoryType: .book,
                    title: "장소 이름",
                    address: "상세주소"
                )
            ]
        )
    }
}

struct Place: Identifiable, Equatable {
    let id = UUID()
    let imageURL: String
    let latitude: Double
    let longitude: Double
    var isFocused: Bool
    var isSaved: Bool
    let placeCategoryType: PlaceCategoryType
    let title: String
    let address: String
}
