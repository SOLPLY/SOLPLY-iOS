//
//  MyPageEditEffect.swift
//  Solply
//
//  Created by 김승원 on 11/12/25.
//

import Foundation

struct MyPageEditEffect {
    private let userService: UserAPI
    private let fileService: FileAPI
    private let uploadPhotosService: UploadPhotosAPI
    
    init(
        userService: UserAPI,
        fileService: FileAPI,
        uploadPhotosService: UploadPhotosAPI
    ) {
        self.userService = userService
        self.fileService = fileService
        self.uploadPhotosService = uploadPhotosService
    }
}

// MARK: - UserAPI

extension MyPageEditEffect {
    func fetchUserNicknameCheck(nickname: String) async -> MyPageEditAction {
        do {
            let response = try await userService.fetchUserNicknameCheck(nickname)
            
            guard let data = response.data else {
                return .fetchUserNicknameCheckFailed(error: .responseError)
            }
            
            return .fetchUserNicknameCheckSuccess(isDuplicated: data.isDuplicated)
        } catch let error as NetworkError {
            return .fetchUserNicknameCheckFailed(error: error)
        } catch {
            return .fetchUserNicknameCheckFailed(error: .unknownError)
        }
    }
    
    func updateUserInformation(request: UpdateUserInformationRequestDTO) async -> MyPageEditAction {
        do {
            let response = try await userService.updateUserInformation(request: request)
            
            guard response.data != nil else {
                return .updateUserInformationFailed(error: .responseError)
            }
            
            return .updateUserInformationSuccess
            
        } catch let error as NetworkError {
            return .updateUserInformationFailed(error: error)
            
        } catch {
            return .updateUserInformationFailed(error: .unknownError)
        }
    }
}

// MARK: - FileAPI

extension MyPageEditEffect {
    func submitPresignedUrlRequest(request: PresignedUrlRequestDTO) async -> MyPageEditAction {
        do {
            let response = try await fileService.submitPresignedUrlRequest(request: request)
            
            guard let data = response.data,
                  let presignedUrl = data.presignedGetUrlInfos.first?.presignedUrl else {
                return .submitPresignedUrlRequestFailed(error: .responseError)
            }
            
            return .submitPresignedUrlRequestSuccess(presignedUrl: presignedUrl)
        } catch let error as NetworkError {
            return .submitPresignedUrlRequestFailed(error: error)
        } catch {
            return .submitPresignedUrlRequestFailed(error: .unknownError)
        }
    }
}

// MARK: - UploadPhotoAPI

extension MyPageEditEffect {
    func uploadImage(dictionary: [URL: Data]) async -> MyPageEditAction {
        do {
            let response = try await uploadPhotosService.uploadImages(dictionary)
            
            guard let imageKey = response.first else {
                return .photoUploadFailed(error: .responseError)
            }
            
            return .photoUploadSuccess(imageKey: imageKey)
            
        } catch let error as NetworkError {
            return .photoUploadFailed(error: error)
        } catch {
            return .photoUploadFailed(error: .unknownError)
        }
    }
}
