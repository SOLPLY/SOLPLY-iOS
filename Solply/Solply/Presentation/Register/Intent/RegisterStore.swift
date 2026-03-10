//
//  RegisterStore.swift
//  Solply
//
//  Created by 김승원 on 10/10/25.
//

import Foundation

@MainActor
final class RegisterStore: ObservableObject {
    @Published private(set) var state = RegisterState()
    private let effect = RegisterEffect(
        tagsService: TagsService(),
        naverPlaceSearchService: NaverPlaceSearchService(),
        placeService: PlaceService(),
        fileService: FileService(),
        uploadPhotosService: UploadPhotosService()
    )
    
    func dispatch(_ action: RegisterAction) {
        RegisterReducer.reduce(state: &state, action: action)
        
        switch action {
            
        case .startRegister:
            if state.attachedImageData.isEmpty {
                self.dispatch(.submitRegister(imageKeyStrings: []))
            } else {
                dispatch(
                    .submitPresignedUrlRequest(
                        request: PresignedUrlRequestDTO(
                            files: state.attachedImageData.map { fileName, _ in
                                File(fileName: fileName)
                                
                            }
                        )
                    )
                )
            }
            
        case .submitPresignedUrlRequest(let request):
            Task {
                let result = await effect.submitPresignedUrlRequest(request: request)
                self.dispatch(result)
            }
            
        case .presignedUrlRequestSubmitted(let response):
            let presignedInformation = response.presignedGetUrlInfos
            let imageDatas = state.attachedImageData

            var presignedDictionary: [URL: Data] = [:]

            for (info, data) in zip(presignedInformation, imageDatas) {
                if let url = URL(string: info.presignedUrl) {
                    presignedDictionary[url] = data.1
                }
            }
            
            Task {
                let result = await effect.uploadImages(dictionary: presignedDictionary)
                self.dispatch(result)
            }
            
        case .photoUploadSuccess(let imageKeys):
            var imageKeyStrings: [String]
            
            imageKeyStrings = imageKeys.map { imageKey in
                imageKey.absoluteString.truncatedForS3()
            }
            
            self.dispatch(.submitRegister(imageKeyStrings: imageKeyStrings))
            
        case .fetchSubTags(let parentId):
            Task {
                let result = await effect.fetchSubTags(parentId: parentId)
                self.dispatch(result)
            }
            
        case .fetchSearchPlaces:
            Task {
                let result = await effect.fetchPlaces(for: state.placeName)
                self.dispatch(result)
            }
            
        case  .submitRegister(let imageKeyStrings):
            guard let mainTagId = state.selectedMainTag?.parentId else { return }
            
            let subTagAIds = state.selectableSubTagsA
                .filter { $0.isSelected }
                .map { $0.id }
            
            let subTagBIds = state.selectableSubTagsB
                .filter { $0.isSelected }
                .map { $0.id }
            
            let images = imageKeyStrings.isEmpty ? nil : imageKeyStrings.enumerated().map { index, imageKeyString in
                RegisterImage(
                    displayOrder: index + 1 ,
                    tempFileKey: imageKeyString
                )
            }
            
            Task {
                let result = await effect.submitRegister(
                    request: RegisterRequestDTO(
                        placeName: state.placeName,
                        address: state.placeAddress ?? "",
                        mainTagId: mainTagId,
                        subTagAIds: subTagAIds,
                        subTagBIds: subTagBIds,
                        reason: state.registerContent,
                        images: images
                    )
                )
                
                self.dispatch(result)
            }
            
        case .registerSubmitted:
            AmplitudeManager.shared.track(
                .completePlaceRequest(
                    submissionType: state.placeAddress != nil ? .selected : .direct
                )
            )
            
        default:
            break
        }
    }
}
