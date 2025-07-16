//
//  CourseDetail.swift
//  Solply
//
//  Created by 김승원 on 7/11/25.
//

import Foundation

struct CourseDetail {
    let courseId: Int
    let courseName: String
    let introduction: String
    var places: [PlaceDetailInCourse]
    
    static func mockData() -> CourseDetail {
        return CourseDetail(
            courseId: 1,
            courseName: "오감으로 수집하는 하루우우우우우우우우우우우우우우우우우우우우우",
            introduction: "귀여운 당고 디저트와 커피, 에이드가 있는 펫 프렌들리 코스",
            places: [
                PlaceDetailInCourse(
                    placeId: 1,
                    thumbnailURL: "",
                    latitude: 37.5694,
                    longitude: 126.9246,
                    isFocused: false,
                    isBookmarked: true,
                    primaryTag: .book,
                    placeName: "장소 이름응응응믕믕믕믕믕응으으으으",
                    address: "상세주소오오오오오오오오오오오오오",
                    contactNumber: "010-0000-0000",
                    snsLink: "상세 주소"
                ),
                PlaceDetailInCourse(
                    placeId: 2,
                    thumbnailURL: "",
                    latitude: 37.5689,
                    longitude: 126.9239,
                    isFocused: false,
                    isBookmarked: false,
                    primaryTag: .unique,
                    placeName: "장소 이름",
                    address: "상세주소",
                    contactNumber: "010-0000-0000",
                    snsLink: "상세 주소"
                ),
                PlaceDetailInCourse(
                    placeId: 3,
                    thumbnailURL: "",
                    latitude: 37.5702,
                    longitude: 126.9253,
                    isFocused: false,
                    isBookmarked: true,
                    primaryTag: .cafe,
                    placeName: "장소 이름",
                    address: "상세주소",
                    contactNumber: "010-0000-0000",
                    snsLink: "상세 주소"
                ),
                PlaceDetailInCourse(
                    placeId: 4,
                    thumbnailURL: "",
                    latitude: 37.5697,
                    longitude: 126.9260,
                    isFocused: false,
                    isBookmarked: false,
                    primaryTag: .food,
                    placeName: "장소 이름",
                    address: "상세주소",
                    contactNumber: "010-0000-0000",
                    snsLink: "상세 주소"
                ),
                PlaceDetailInCourse(
                    placeId: 5,
                    thumbnailURL: "",
                    latitude: 37.5685,
                    longitude: 126.9235,
                    isFocused: false,
                    isBookmarked: false,
                    primaryTag: .shopping,
                    placeName: "장소 이름",
                    address: "상세주소",
                    contactNumber: "010-0000-0000",
                    snsLink: "상세 주소"
                ),
                PlaceDetailInCourse(
                    placeId: 6,
                    thumbnailURL: "",
                    latitude: 37.5699,
                    longitude: 126.9248,
                    isFocused: false,
                    isBookmarked: false,
                    primaryTag: .book,
                    placeName: "장소 이름",
                    address: "상세주소",
                    contactNumber: "010-0000-0000",
                    snsLink: "상세 주소"
                )
            ]
        )
    }
}
