//
//  SubTagType.swift
//  Solply
//
//  Created by seozero on 7/17/25.
//

import Foundation

enum SubTagType: String, ResponseModelType, RequestModelType {

    // MARK: - 카페 추천 옵션 1
    case coffeeDessert = "커피/디저트"
    case work = "작업"
    case reading = "독서"
    case healing = "힐링"

    // MARK: - 카페 추천 옵션 2
    case signatureMenu = "시그니처메뉴"
    case moodInterior = "감성인테리어"
    case sunlight = "채광좋음"
    case manyPlug = "콘센트많음"
    case noTimeLimit = "시간제한없음"
    case barTable = "바테이블"

    // MARK: - 음식 추천 옵션 1
    case koreanFood = "한식"
    case chineseFood = "중식"
    case japaneseFood = "일식"
    case westernFood = "양식"
    case bar = "바/술집"
    case bakery = "베이커리"
    case asianFood = "아시안푸드"

    // MARK: - 음식 추천 옵션 2
    case singleMenu = "1인메뉴"
    case selfService = "셀프서비스"

    // MARK: - 이색공간 추천 옵션
    case art = "문화예술"
    case workshop = "공방/클래스"

    // MARK: - 쇼핑 추천 옵션
    case lifestyleShop = "소품샵"
    case vintageShop = "빈티지샵"
    case popupMarket = "팝업/플리마켓"
    
    
    var title: String {
        switch self {
        case .coffeeDessert: return "커피/디저트"
        case .work: return "작업"
        case .reading: return "독서"
        case .healing: return "힐링"
        case .signatureMenu: return "시그니처 메뉴"
        case .moodInterior: return "감성 인테리어"
        case .sunlight: return "채광 좋음"
        case .manyPlug: return "콘센트 많음"
        case .noTimeLimit: return "시간제한없음"
        case .barTable: return "바테이블"
        case .koreanFood: return "한식"
        case .chineseFood: return "중식"
        case .japaneseFood: return "일식"
        case .westernFood: return "양식"
        case .bar: return "바/술집"
        case .bakery: return "베이커리"
        case .asianFood: return "아시안푸드"
        case .singleMenu: return "1인메뉴"
        case .selfService: return "셀프서비스"
        case .art: return "문화예술"
        case .workshop: return "공방/클래스"
        case .lifestyleShop: return "소품샵"
        case .vintageShop: return "빈티지샵"
        case .popupMarket: return "팝업/플리마켓"
        }
    }
}
