//
//  AmplitudeEvent.swift
//  Solply
//
//  Created by 김승원 on 1/20/26.
//

import Foundation

enum AmplitudeEvent {
    case clickBrowseMode(entryMode: AmplitudeEntryMode)
    case viewLoginRequiredAlert(entryMode: AmplitudeEntryMode, blockedAction: AmplitudeBlockedAction)
    case clickLoginCancel(entryMode: AmplitudeEntryMode, blockedAction: AmplitudeBlockedAction)
    case clickLogin(loginMethod: AmplitudeLoginMethod, loginEntryType: AmplitudeLoginEntryType)
    case completeTerms(loginEntryType: AmplitudeLoginEntryType)
    case completePersona(personaType: AmplitudePersonaType, loginEntryType: AmplitudeLoginEntryType)
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
            
        case .clickLogin(let loginMethod, let loginEntryType):
            return [
                AmplitudePropertyKey.loginMethod.rawValue: loginMethod.rawValue,
                AmplitudePropertyKey.loginEntryType.rawValue: loginEntryType.rawValue
            ]
            
        case .completeTerms(let loginEntryType):
            return [
                AmplitudePropertyKey.loginEntryType.rawValue: loginEntryType.rawValue
            ]
            
        case .completePersona(let personaType, let loginEntryType):
            return [
                AmplitudePropertyKey.personaType.rawValue: personaType.rawValue,
                AmplitudePropertyKey.loginEntryType.rawValue: loginEntryType.rawValue
            ]
        }
    }
}
