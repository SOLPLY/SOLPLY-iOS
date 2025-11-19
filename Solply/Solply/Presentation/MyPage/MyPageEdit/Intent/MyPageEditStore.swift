//
//  MyPageEditStore.swift
//  Solply
//
//  Created by sun on 9/26/25.
//

import Foundation

@MainActor
final class MyPageEditStore: ObservableObject {
    
    // MARK: - Properites
    
    @Published private(set) var state = MyPageEditState()
    
    private let effect: MyPageEditEffect
    
    let userInformation: UserInformation
    
    // MARK: - Initializer
    
    init(
        effect: MyPageEditEffect = MyPageEditEffect(
            userService: UserService(),
            fileService: FileService(),
            uploadPhotosService: UploadPhotosService()
        ),
        userInformation: UserInformation,
    ) {
        self.effect = effect
        self.userInformation = userInformation
    }
    
    // MARK: - Dispatch
    
    func dispatch(_ action: MyPageEditAction) {
        MyPageEditReducer.reduce(state: &state, action: action)
        
        switch action {
            
        case .loadUserInformation:
            state.nickname = userInformation.nickname
            // TODO: -  이게 진짜 필요한 건가 고민해보자
            
        case .fetchUserNicknameCheck:
            Task {
                let result = await effect.fetchUserNicknameCheck(nickname: state.nickname)
                self.dispatch(result)
            }
            
        case .startUpdateUserInformation:
            if let attachedImageData = state.attachedImageData {
                if attachedImageData.0.isEmpty {
                    self.dispatch(.updateUserInformation(imageKeyString: ""))
                } else {
                    self.dispatch(
                        .submitPresignedUrlRequest(
                            request: PresignedUrlRequestDTO(
                                files: [File(fileName: attachedImageData.0)]
                            )
                        )
                    )
                }
            } else {
                self.dispatch(.updateUserInformation(imageKeyString: nil))
            }
            
        case .submitPresignedUrlRequest(let request):
            Task {
                let result = await effect.submitPresignedUrlRequest(request: request)
                self.dispatch(result)
            }
            
        case .submitPresignedUrlRequestSuccess(let presignedUrl):
            guard let attachedImageData = state.attachedImageData else { return }
            
            var presignedDictionary: [URL: Data] = [:]
            
            if let url = URL(string: presignedUrl) {
                presignedDictionary[url] = attachedImageData.1
            }
            
            Task {
                let result = await effect.uploadImage(dictionary: presignedDictionary)
                self.dispatch(result)
            }
            
        case .photoUploadSuccess(let imageKey):
            let imageKeyString = imageKey.absoluteString.truncated(includeStartRange: "dev", excludeEndRange: "?")
            
            self.dispatch(.updateUserInformation(imageKeyString: imageKeyString))
            
        case .updateUserInformation(let imageKeyString):
            let nickname = state.nickname.isEmpty ? userInformation.nickname : state.nickname
            let persona = PersonaType.allCases.first { $0.personaString == state.selectedPersona }?.rawValue ?? userInformation.persona.rawValue
            
            let request =  UpdateUserInformationRequestDTO(
                nickname: nickname,
                persona: persona,
                profileImageFileKey: imageKeyString
            )
            
            Task {
                let result = await effect.updateUserInformation(request: request)
                self.dispatch(result)
            }
        default:
            break
        }
    }
}
