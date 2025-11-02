//
//  RegisterAction.swift
//  Solply
//
//  Created by 김승원 on 10/10/25.
//

import Foundation

enum RegisterAction {
    case updateSearchBarText(text: String)
    case selectPlaceToRegister(placeName: String, placeAddress: String?)
    case selectMainTag(mainTag: MainTagType)
    case selectSubTagA(selectableSubTags: [SelectableSubTag])
    case selectSubTagB(selectableSubTags: [SelectableSubTag])
    case editReigsterContent(registerContent: String)
    case attachRegisterPhoto(imageData: [(String, Data)])
    
    case startRegister
    case endRegister
    
    // api
    case errorOccured(error: NetworkError)
    case fetchSubTags(parentId: Int)
    case subTagsFetched(selectableSubTags: [SelectableSubTag])
    
    case fetchSearchPlaces
    case searchPlacesFetched(places: [RegisterSearch])
    case fetchSearchPlacesFailed(error: NetworkError)
    
    case submitRegister(imageKeyStrings: [String])
    case registerSubmitted
    case submitRegisterFailed(error: NetworkError)
    
    case submitPresignedUrlRequest(request: PresignedUrlRequestDTO)
    case presignedUrlRequestSubmitted(response: PresignedUrlResponseDTO)
    case submitPresignedUrlRequestFailed(error: NetworkError)
    
    case photoUploadSuccess(imageKeys: [URL])
    case photoUploadFailed(error: NetworkError)
}
