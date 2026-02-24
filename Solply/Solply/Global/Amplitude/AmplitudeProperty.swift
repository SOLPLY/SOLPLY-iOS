//
//  AmplitudeProperty.swift
//  Solply
//
//  Created by 김승원 on 1/20/26.
//

import Foundation

// MARK: - Property Key String

/// [Amplitude] - Property Key String
enum AmplitudePropertyKey: String {
    
    // 공통
    case entryMode = "entry_mode"
    
    // 온보딩
    case loginMethod = "login_method"
    case loginEntryType = "login_entry_type"
    case blockedAction = "blocked_action"
    case isNewUser = "is_new_user"
    case personaType = "persona_type"
    
    // 유입 맥락
    case fromContext = "from_context"
    
    // 동네 선택
    case townId = "town_id"
    case townName = "town_name"
    case prevTownId = "prev_town_id"
    
    // 장소 리스트, 필터
    case mainTag = "main_tag"
    case selectedMainTag = "selected_maintag"
    case selectedOptionTags = "selected_option_tags"
    case resultCount = "result_count"
    case optionTag = "option_tag"
    case tagAction = "tag_action"
    case optionTagCount = "option_tag_count"
    
    // 장소 상세, 제보, 저장
    case placeId = "place_id"
    case placeName = "place_name"
    case reportType = "report_type"
    case hasText = "has_text"
    case isBookmared = "is_bookmarked"
    case saveAction = "save_action"
    
    // 길찾기, 지도
    case mapProvider = "map_provider"
    
    // 검색, 장소 등록 요청
    case isEmpty = "is_empty"
    case entryRoute = "entry_route"
    case submissionType = "submission_type"
    
    // 코스
    case hasCourse = "has_course"
    case courseCount = "course_count"
    case courseId = "course_id"
    
    // 코스 상세
    case mainTags = "main_tags"
    case entryPoint = "entry_point"
    case fromIndex = "from_index"
    case toIndex = "to_index"
    case saveMode = "save_mode"
    case changedFields = "changed_fields"
    case placeCount = "place_count"
    case choice = "choice"
    
    // 수집함
    case collectionType = "collection_type"
    case townCount = "town_count"
    case removeCount = "remove_count"
    
    // 마이페이지
    case prevPersona = "prev_persona"
    case newPersona = "new_persona"
    case withdrawType = "withdraw_type"
}

// MARK: - Properties

/// [Amplitude] - 현재 세션의 진입 모드 Property
enum AmplitudeEntryMode: String {
    case guest
    case member
}

/// [Amplitude] - 로그인에 사용한 수단 Property
enum AmplitudeLoginMethod: String {
    case kakao
    case apple
}

/// [Amplitude] - 로그인 플로우 진입 유형 Property
enum AmplitudeLoginEntryType: String {
    case blocked
    case direct
}

/// [Amplitude] - 로그인 차단을 유발한 사용자 행동 Property
enum AmplitudeBlockedAction: String {
    case savePlace = "save_place"
    case addToCourse = "add_to_course"
    case reportError = "report_error"
    case saveCourse = "save_course"
    case saveCoursePlace = "save_course_place"
    case openCollectionTab = "open_collection_tab"
    case openMyPageTab = "open_my_page_tab"
    case requestPlaceRegister = "request_place_register"
    case todayRecommend = "today_reco"
}

/// [Amplitude] - 사용자 페르소나 유형 Property, 변경 전, 변경 후 공통 사용
enum AmplitudePersonaType: String {
    case rest
    case explorer
    case mooding
    case natural
}

/// [Amplitude] - 직전 화면/기능(진입경로) Property
enum AmplitudeFromContext: String {
    case todayRecommend = "today_reco"
    case placeList = "place_list"
    case searchResult = "search_result"
    case collection = "collection"
    case courseDetail = "course_detail"
    case tabCourse = "tab_course"
    case addToCourse = "add_to_course"
    case courseList = "course_list"
    case placeDetail = "place_detail"
}

protocol AmplitudeTag {}

extension AmplitudeSelectedMainTag: AmplitudeTag {}
extension AmplitudeSelectedOptionTag: AmplitudeTag {}

/// [Amplitude] - 선택된 메인 태그
enum AmplitudeSelectedMainTag: String {
    case all = "all"
    case cafe = "cafe"
    case food = "food"
    case shopping = "shopping"
    case bookstore = "bookstore"
    case uniqueSpace = "unique_space"
    case walking = "walking"
}

/// [Amplitude] - 선택된 옵션 태그 목록
enum AmplitudeSelectedOptionTag: String {
    // OPTION1
    case coffeeDessert = "coffee_dessert"
    case work = "work"
    case reading = "reading"
    case healing = "healing"
    case koreanFood = "korean_food"
    case chineseFood = "chinese_food"
    case japaneseFood = "japanese_food"
    case westernFood = "western_food"
    case asianFood = "asian_food"
    case bar = "bar"
    case bakery = "bakery"
    case art = "art"
    case workshop = "workshop"
    case lifestyleShop = "lifestyle_shop"
    case vintageShop = "vintage_shop"

    // OPTION2
    case signatureMenu = "signature_menu"
    case moodInterior = "mood_interior"
    case sunlight = "sunlight"
    case manyPlug = "many_plug"
    case noTimeLimit = "no_time_limit"
    case barTable = "bar_table"
    case singleMenu = "single_menu"
    case selfService = "self_service"
    case popupMarket = "popup_market"
}

/// [Amplitude] - 선택된 옵션 태그 개수
enum AmplitudeTagAction: String {
    case select
    case deselect
}

/// [Amplitude] - 제보 유형
enum AmplitudeReportType: String {
    case storeClosed = "store_closed"
    case wrongAddress = "wrong_address"
    case wrongPhone = "wrong_phone"
    case wrongHours = "wrong_hours"
    case wrongCategorfy = "wrong_categorfy"
    case other = "other"
}

/// [Amplitude] - 저장/해제 액션(장소/코스 공통)
enum AmplitudeSaveAction: String {
    case save
    case unsave
}

/// [Amplitude] - 길찾기 시 선택한 지도 앱
enum AmplitudeMapProvider: String {
    case appleMaps = "applemaps"
    case kakao
    case naver
}

/// [Amplitude] - 등록 플로우에 진입한 출발점
enum AmplitudeEntryRoute: String {
    case noResults = "no_results"
    case notFound = "not_found"
}

/// [Amplitude] - 장소 등록 요청 제출 방식
enum AmplitudeSubmissionType: String {
    case direct
    case selected
}

/// [Amplitude] - 코스 수정 화면 진입 지점
enum AmplitudeEntryPoint: String {
    case toast
    case collection
}

/// [Amplitude] - 코스 저장 방식
enum AmplitudeSaveMode: String {
    case current
    case new
}

/// [Amplitude] - 수정된 필드 목록
enum AmplitudeChangedField: String {
    case title = "title"
    case intro = "intro"
    case order = "order"
    case removePlace = "remove_place"
    case nickname = "nickname"
    case personaType = "persona_type"
}

enum AmplitudeCollectionType: String {
    case place
    case course
}

/// [Amplitude] - 코스 수정 이탈 모달 사용자 선택
enum AmplitudeChoice: String {
    case leave
    case cancel
}

/// [Amplitude] - 탈퇴 유형(사유 분류)
enum AmplitudeWithdrawType: String {
    case notUse = "not_use"
    case deficientInfo = "deficient_info"
    case inconvenient = "inconvenient"
    case hateRecommend = "hate_recommend"
    case useOtherService = "use_other_service"
    case others = "others"
}

// MARK: - From

extension AmplitudePersonaType {
    static func from(_ persona: Persona) -> AmplitudePersonaType {
        switch persona.type.uppercased() {
        case "REST": return .rest
        case "EXPLORER": return .explorer
        case "MOODING": return .mooding
        case "NATURAL": return .natural
        default: return .rest
        }
    }
    
    static func from(personaType: PersonaType) -> AmplitudePersonaType {
        switch personaType {
        case .healing: return .rest
        case .explorer: return .explorer
        case .mooding: return .mooding
        case .natural: return .natural
        }
    }
    
    static func from(text: String) -> AmplitudePersonaType? {
        let personaType = AmplitudePersonaType(rawValue: text)
        
        switch personaType {
        case .rest: return .rest
        case .explorer: return .explorer
        case .mooding: return .mooding
        case .natural: return .natural
        case nil: return nil
        }
    }
}

extension AmplitudeEntryMode {
    static func from(_ userSession: UserSession) -> AmplitudeEntryMode {
        switch userSession {
        case .explore: return .guest
        case .authenticated: return .member
        }
    }
}


extension AmplitudeSelectedMainTag {
    static func from(_ mainTagType: MainTagType) -> AmplitudeSelectedMainTag {
        switch mainTagType {
        case .all: return .all
        case .cafe: return .cafe
        case .food: return .food
        case .shopping: return .shopping
        case .book: return .bookstore
        case .unique: return .uniqueSpace
        case .walk: return .walking
        }
    }
}

extension AmplitudeSelectedOptionTag {
    static func from(_ subTagType: SubTagType) -> AmplitudeSelectedOptionTag {
        switch subTagType {
        case .coffeeDessert: return .coffeeDessert
        case .work: return .work
        case .reading: return .reading
        case .healing: return .healing
        case .signatureMenu: return .signatureMenu
        case .moodInterior: return .moodInterior
        case .sunlight: return .sunlight
        case .manyPlug: return .manyPlug
        case .noTimeLimit: return .noTimeLimit
        case .barTable: return .barTable
        case .koreanFood: return .koreanFood
        case .chineseFood: return .chineseFood
        case .japaneseFood: return .japaneseFood
        case .westernFood: return .westernFood
        case .bar: return .bar
        case .bakery: return .bakery
        case .asianFood: return .asianFood
        case .singleMenu: return .singleMenu
        case .selfService: return .selfService
        case .art: return .art
        case .workshop: return .workshop
        case .lifestyleShop: return .lifestyleShop
        case .vintageShop: return .vintageShop
        case .popupMarket: return .popupMarket
        }
    }
}

extension AmplitudeWithdrawType {
    static func from(_ withdrawType: WithdrawType) -> AmplitudeWithdrawType {
        switch withdrawType {
        case .notUse: return .notUse
        case .deficientInfo: return .deficientInfo
        case .inconvenient: return .inconvenient
        case .hateRecommend: return .hateRecommend
        case .useOtherService: return .useOtherService
        case .others: return .others
        }
    }
}

extension AmplitudeCollectionType {
    static func from(_ solplyContentType: SolplyContentType) -> AmplitudeCollectionType {
        switch solplyContentType {
        case .place: return .place
        case .course: return .course
        }
    }
}
