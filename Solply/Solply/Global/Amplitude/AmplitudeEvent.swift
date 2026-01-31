//
//  AmplitudeEvent.swift
//  Solply
//
//  Created by 김승원 on 1/20/26.
//

import Foundation

enum AmplitudeEvent {
    
    // 온보딩
    case clickBrowseMode(entryMode: AmplitudeEntryMode)
    case viewLoginRequiredAlert(entryMode: AmplitudeEntryMode, blockedAction: AmplitudeBlockedAction)
    case clickLoginCancel(entryMode: AmplitudeEntryMode, blockedAction: AmplitudeBlockedAction)
    case clickLogin(loginMethod: AmplitudeLoginMethod)
    case completeTerms
    case completePersona(personaType: AmplitudePersonaType)
    case completeNickname(entryMode: AmplitudeEntryMode, personaType: AmplitudePersonaType, loginEntryType: AmplitudeLoginEntryType)
    case successLogin(isNewUser: Bool)
    
    // 동네선택
    case viewTownList(entryMode: AmplitudeEntryMode, fromContext: AmplitudeFromContext)
    case selectTown(townId: Int, townName: String, prevTownId: Int)
    
    // 장소 추천 홈
    case viewPlaceList(townId: Int)
    case viewPlaceFilter(townId: Int)
    case selectPlaceMainTag(mainTag: AmplitudeSelectedMainTag, townId: Int, townName: String)
    case viewPlaceOptionPanel(townId: Int, townName: String, selectedMainTag: AmplitudeSelectedMainTag)
    case completePlaceFilter(selectedOptionTags: [AmplitudeSelectedOptionTag], optionTagCount: Int, townId: Int, townName: String)
    
    // 장소 상세
    case viewPlaceDetail(placeId: Int, placeName: String, fromContext: AmplitudeFromContext, isBookmared: Bool)
    case successPlaceSave(placeId: Int, placeName: String, saveAction: AmplitudeSaveAction)
    case clickPlaceDirections(placeId: Int, placeName: String, fromContext: AmplitudeFromContext)
    case viewAddToCourse(placeId: Int, hasCourse: Bool)
    case completeAddPlaceToCourse(placeId: Int, placeName: String, courseId: Int)
    case clickFindNewCourse
    
    // 장소 검색
    case viewSearch(entryMode: AmplitudeEntryMode)
    case viewSearchResult(isEmpty: Bool)
    case clickManualPlaceEntry(entryRoute: AmplitudeEntryRoute)
    case clickPlaceRequest(entryRoute: AmplitudeEntryRoute)
    case completePlaceRequest(submissionType: AmplitudeSubmissionType)
    
    // 코스 추천 홈
    case viewCourseList(townId: Int, townName: String)
    
    // 코스 상세
    case viewCourseDetail(entryMode: AmplitudeEntryMode, courseId: Int, isBookmarked: Bool, fromContext: AmplitudeFromContext)
    case successCourseSave(courseId: Int, saveAction: AmplitudeSaveAction)
    case clickCoursePlaceCard(courseId: Int, placeId: Int, placeName: String)
    case clickCoursePlaceSave(courseId: Int, placeId: Int, saveAction: AmplitudeSaveAction)
    
    // 코스 수정
    case viewCourseEdit(courseId: Int, entryPoint: AmplitudeEntryPoint)
    case completeCourseEdit(courseId: Int, saveMode: AmplitudeSaveMode, changedFields: [AmplitudeChangedField], placeCount: Int)
    case clickLeaveCourseEdit(courseId: Int, choice: AmplitudeChoice)
    
    // 마이페이지
    case viewMyPage(entryMode: AmplitudeEntryMode)
    case completeProfileEdit(changedFields: [AmplitudeChangedField], prevPersona: AmplitudePersonaType, newPersona: AmplitudePersonaType)
    case completeWithdraw(withdrawType: AmplitudeWithdrawType)
    
    // 수집함
    case viewCollectionTownList(collectionType: AmplitudeCollectionType)
    case viewCollectionPlaceList(townId: Int, townName: String, collectionType: AmplitudeCollectionType, placeCount: Int)
    case completeRemoveCollectionItems(removeCount: Int)
}

extension AmplitudeEvent {
    var name: String {
        switch self {
        case .clickBrowseMode: return "click_browse_mode"
        case .viewLoginRequiredAlert: return "view_login_required_alert"
        case .clickLoginCancel: return "click_login_cancel"
        case .clickLogin: return "click_login"
        case .completeTerms: return "complete_terms"
        case .completePersona: return "complete_persona"
        case .completeNickname: return "complete_nickname"
        case .successLogin: return "success_login"
        case .viewTownList: return "view_town_list"
        case .selectTown: return "select_town"
        case .viewPlaceList: return "view_place_list"
        case .viewPlaceFilter: return "view_place_filter"
        case .selectPlaceMainTag: return "select_place_main_tag"
        case .viewPlaceOptionPanel: return "view_place_option_panel"
        case .completePlaceFilter: return "complete_place_filter"
        case .viewPlaceDetail: return "view_place_detail"
        case .successPlaceSave: return "success_place_save"
        case .clickPlaceDirections: return "click_place_directions"
        case .viewAddToCourse: return "view_add_to_course"
        case .completeAddPlaceToCourse: return "complete_add_place_to_course"
        case .clickFindNewCourse: return "click_find_new_course"
        case .viewSearch: return "view_search"
        case .viewSearchResult: return "view_search_result"
        case .clickManualPlaceEntry: return "click_manual_place_entry"
        case .clickPlaceRequest: return "click_place_request"
        case .completePlaceRequest: return "complete_place_request"
        case .viewCourseList: return "view_course_list"
        case .viewCourseDetail: return "view_course_detail"
        case .successCourseSave: return "success_course_save"
        case .clickCoursePlaceCard: return "click_course_place_card"
        case .clickCoursePlaceSave: return "click_course_place_save"
        case .viewCourseEdit: return "view_course_edit"
        case .completeCourseEdit: return "complete_course_edit"
        case .clickLeaveCourseEdit: return "click_leave_course_edit"
        case .viewMyPage: return "view_my_page"
        case .completeProfileEdit: return "complete_profile_edit"
        case .completeWithdraw: return "complete_withdraw"
        case .viewCollectionTownList: return "view_collection_town_list"
        case .viewCollectionPlaceList: return "view_collection_place_list"
        case .completeRemoveCollectionItems: return "complete_remove_collection_items"
        }
    }
    
    var properties: [String : Any] {
        switch self {
        case .clickBrowseMode(let entryMode):
            return [
                AmplitudePropertyKey.entryMode.rawValue: entryMode.rawValue
            ]
        
        case .viewLoginRequiredAlert(let entryMode, let blockedAction):
            return [
                AmplitudePropertyKey.entryMode.rawValue: entryMode.rawValue,
                AmplitudePropertyKey.blockedAction.rawValue: blockedAction.rawValue
            ]
            
        case .clickLoginCancel(let entryMode, let blockedAction):
            return [
                AmplitudePropertyKey.entryMode.rawValue: entryMode.rawValue,
                AmplitudePropertyKey.blockedAction.rawValue: blockedAction.rawValue
            ]
            
        case .clickLogin(let loginMethod):
            return [
                AmplitudePropertyKey.loginMethod.rawValue: loginMethod.rawValue
            ]
            
        case .completeTerms:
            return [:]
            
        case .completePersona(let personaType):
            return [
                AmplitudePropertyKey.personaType.rawValue: personaType.rawValue
            ]
            
        case .completeNickname(let entryMode, let personatype, let loginEntryType):
            return [
                AmplitudePropertyKey.entryMode.rawValue: entryMode.rawValue,
                AmplitudePropertyKey.personaType.rawValue: personatype.rawValue,
                AmplitudePropertyKey.loginEntryType.rawValue: loginEntryType.rawValue
            ]
            
        case .successLogin(let isNewUser):
            return [
                AmplitudePropertyKey.isNewUser.rawValue: isNewUser
            ]
            
        case .viewTownList(let entryMode, let fromContext):
            return [
                AmplitudePropertyKey.entryMode.rawValue: entryMode.rawValue,
                AmplitudePropertyKey.fromContext.rawValue: fromContext.rawValue
            ]
            
        case .selectTown(let townId, let townName, let prevTownId):
            return [
                AmplitudePropertyKey.townId.rawValue: townId,
                AmplitudePropertyKey.townName.rawValue: townName,
                AmplitudePropertyKey.prevTownId.rawValue: prevTownId
            ]
            
        case .viewPlaceList(let townId):
            return [
                AmplitudePropertyKey.townId.rawValue: townId
            ]
            
        case .viewPlaceFilter(let townId):
            return [
                AmplitudePropertyKey.townId.rawValue: townId
            ]
            
        case .selectPlaceMainTag(let mainTag, let townId, let townName):
            return[
                AmplitudePropertyKey.mainTag.rawValue: mainTag.rawValue,
                AmplitudePropertyKey.townId.rawValue: townId,
                AmplitudePropertyKey.townName.rawValue: townName
            ]
            
        case .viewPlaceOptionPanel(let townId, let townName, let selectedMainTag):
            return [
                AmplitudePropertyKey.townId.rawValue: townId,
                AmplitudePropertyKey.townName.rawValue: townName,
                AmplitudePropertyKey.selectedMainTag.rawValue: selectedMainTag.rawValue
            ]
            
        case .completePlaceFilter(let selectedOptionTags, let optionTagCount, let townId, let townName):
            return [
                AmplitudePropertyKey.selectedOptionTags.rawValue: selectedOptionTags.map { $0.rawValue },
                AmplitudePropertyKey.optionTagCount.rawValue: optionTagCount,
                AmplitudePropertyKey.townId.rawValue: townId,
                AmplitudePropertyKey.townName.rawValue: townName
            ]
            
        case .viewPlaceDetail(let placeId, let placeName, let fromContext, let isBookmared):
            return [
                AmplitudePropertyKey.placeId.rawValue: placeId,
                AmplitudePropertyKey.placeName.rawValue: placeName,
                AmplitudePropertyKey.fromContext.rawValue: fromContext.rawValue,
                AmplitudePropertyKey.isBookmared.rawValue: isBookmared
            ]
            
        case .successPlaceSave(let placeId, let placeName, let saveAction):
            return [
                AmplitudePropertyKey.placeId.rawValue: placeId,
                AmplitudePropertyKey.placeName.rawValue: placeName,
                AmplitudePropertyKey.saveAction.rawValue: saveAction.rawValue
            ]
            
        case .clickPlaceDirections(let placeId, let placeName, let fromContext):
            return [
                AmplitudePropertyKey.placeId.rawValue: placeId,
                AmplitudePropertyKey.placeName.rawValue: placeName,
                AmplitudePropertyKey.fromContext.rawValue: fromContext.rawValue
            ]
            
        case .viewAddToCourse(let placeId, let hasCourse):
            return[
                AmplitudePropertyKey.placeId.rawValue: placeId,
                AmplitudePropertyKey.hasCourse.rawValue: hasCourse
            ]
            
        case .completeAddPlaceToCourse(let placeId, let placeName, let courseId):
            return [
                AmplitudePropertyKey.placeId.rawValue: placeId,
                AmplitudePropertyKey.placeName.rawValue: placeName,
                AmplitudePropertyKey.courseId.rawValue: courseId
            ]
            
        case .clickFindNewCourse:
            return [:]
            
        case .viewSearch(let entryMode):
            return [
                AmplitudePropertyKey.entryMode.rawValue: entryMode.rawValue
            ]
            
        case .viewSearchResult(let isEmpty):
            return [
                AmplitudePropertyKey.isEmpty.rawValue: isEmpty
            ]
            
        case .clickManualPlaceEntry(let entryRoute):
            return [
                AmplitudePropertyKey.entryRoute.rawValue: entryRoute.rawValue
            ]
            
        case .clickPlaceRequest(let entryRoute):
            return [
                AmplitudePropertyKey.entryRoute.rawValue: entryRoute.rawValue
            ]
            
        case .completePlaceRequest(let submissionType):
            return [
                AmplitudePropertyKey.submissionType.rawValue: submissionType.rawValue
            ]
            
        case .viewCourseList(let townId, let townName):
            return [
                AmplitudePropertyKey.townId.rawValue: townId,
                AmplitudePropertyKey.townName.rawValue: townName
            ]
            
        case .viewCourseDetail(let entryMode, let courseId, let isBookmarked, let fromContext):
            return [
                AmplitudePropertyKey.entryMode.rawValue: entryMode.rawValue,
                AmplitudePropertyKey.courseId.rawValue: courseId,
                AmplitudePropertyKey.isBookmared.rawValue: isBookmarked,
                AmplitudePropertyKey.fromContext.rawValue: fromContext.rawValue
            ]
            
        case .successCourseSave(let courseId, let saveAction):
            return [
                AmplitudePropertyKey.courseId.rawValue: courseId,
                AmplitudePropertyKey.saveAction.rawValue: saveAction.rawValue
            ]
            
        case .clickCoursePlaceCard(let courseId, let placeId, let placeName):
            return [
                AmplitudePropertyKey.courseId.rawValue: courseId,
                AmplitudePropertyKey.placeId.rawValue: placeId,
                AmplitudePropertyKey.placeName.rawValue: placeName
            ]
            
        case .clickCoursePlaceSave(let courseId, let placeId, let saveAction):
            return [
                AmplitudePropertyKey.courseId.rawValue: courseId,
                AmplitudePropertyKey.placeId.rawValue: placeId,
                AmplitudePropertyKey.saveAction.rawValue: saveAction.rawValue
            ]
            
        case .viewCourseEdit(let courseId, let entryPoint):
            return [
                AmplitudePropertyKey.courseId.rawValue: courseId,
                AmplitudePropertyKey.entryPoint.rawValue: entryPoint.rawValue
            ]
            
        case .completeCourseEdit(let courseId, let saveMode, let changedFields, let placeCount):
            return [
                AmplitudePropertyKey.courseId.rawValue: courseId,
                AmplitudePropertyKey.saveMode.rawValue: saveMode.rawValue,
                AmplitudePropertyKey.changedFields.rawValue: changedFields.map { $0.rawValue },
                AmplitudePropertyKey.placeCount.rawValue: placeCount
            ]
            
        case .clickLeaveCourseEdit(let courseId, let choice):
            return [
                AmplitudePropertyKey.courseId.rawValue: courseId,
                AmplitudePropertyKey.choice.rawValue: choice.rawValue
            ]
            
        case .viewMyPage(let entryMode):
            return [
                AmplitudePropertyKey.entryMode.rawValue: entryMode.rawValue
            ]
            
        case .completeProfileEdit(let changedFields, let prevPersona, let newPersona):
            return [
                AmplitudePropertyKey.changedFields.rawValue: changedFields.map { $0.rawValue },
                AmplitudePropertyKey.prevPersona.rawValue: prevPersona.rawValue,
                AmplitudePropertyKey.newPersona.rawValue: newPersona.rawValue
            ]
            
        case .completeWithdraw(let withdrawType):
            return [
                AmplitudePropertyKey.withdrawType.rawValue: withdrawType.rawValue
            ]
            
        case .viewCollectionTownList(let collectionType):
            return [
                AmplitudePropertyKey.collectionType.rawValue: collectionType.rawValue
            ]
            
        case .viewCollectionPlaceList(let townId, let townName, let collectionType, let placeCount):
            return [
                AmplitudePropertyKey.townId.rawValue: townId,
                AmplitudePropertyKey.townName.rawValue: townName,
                AmplitudePropertyKey.collectionType.rawValue: collectionType.rawValue,
                AmplitudePropertyKey.placeCount.rawValue: placeCount
            ]
            
        case .completeRemoveCollectionItems(let removeCount):
            return [
                AmplitudePropertyKey.removeCount.rawValue: removeCount
            ]
        }
    }
}
