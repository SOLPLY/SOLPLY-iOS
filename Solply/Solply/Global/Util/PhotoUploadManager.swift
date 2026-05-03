//
//  PhotoUploadManager.swift
//  Solply
//
//  Created by 김승원 on 4/12/26.
//

import Foundation

@MainActor
final class PhotoUploadManager {
    
    // MARK: - Singleton
    
    static let shared = PhotoUploadManager()
    private init() {}
    
    // MARK: - Properties
    
    private let fileService = FileService()
    private let uploadPhotosService = UploadPhotosService()
    
    // MARK: - Functions
    
    /// 이미지 데이터를 받아 S3에 업로드하고 imageKey 문자열 배열을 반환합니다.
    /// 업로드 실패 시 빈 배열을 반환합니다.
    ///
    /// 1. Presigned URL 요청
    /// 2. URL-Data 딕셔너리 생성
    /// 3. 이미지 업로드
    /// 4. ImageKey 가공
    ///
    /// - Parameter imageDatas: 업로드할 이미지의 파일명 & Data 튜플 배열
    /// - Returns: S3에 업로드된 이미지의 key 문자열 배열
    func upload(imageDatas: [(fileName: String, data: Data)]) async -> [String] {
        guard !imageDatas.isEmpty else {
            log("업로드할 이미지가 없습니다")
            return []
        }
        
        log("🌐 이미지 업로드 시작 - 이미지 수 \(imageDatas.count)")
        
        do {
            let presignedInformation = try await fetchPresignedURLs(
                imageDatas: imageDatas
            )
            
            let presignedDictionary = makePresignedDictionary(
                presignedInformation: presignedInformation,
                imageDatas: imageDatas
            )
            
            let imageKeys = try await uploadImages(
                presignedDictionary: presignedDictionary
            )
            
            let imageKeyStrings = makeImageKeyStrings(imageKeys: imageKeys)
            
            log("✅ 이미지 업로드 성공 - imageKeys: \(imageKeyStrings)")
            return imageKeyStrings
        } catch {
            log("❌ 이미지 업로드 실패 - error: \(error)")
            return []
        }
    }
}

// MARK: - Private Functions

private extension PhotoUploadManager {
    
    /// Presigned URL을 서버에 요청합니다.
    /// - Parameter imageDatas: 업로드할 이미지의 파일명 & Data 튜플 배열
    /// - Returns: 서버로부터 받은 Presigned URL 정보 배열
    func fetchPresignedURLs(
        imageDatas: [(fileName: String, data: Data)]
    ) async throws -> [PresignedUrlInformation] {
        log("Presigned URL 요청 시작 - 파일명: \(imageDatas.map { $0.fileName })")
        let request = PresignedUrlRequestDTO(
            files: imageDatas.map { File(fileName: $0.fileName) }
        )
        let response = try await fileService.submitPresignedUrlRequest(request: request)
        
        guard let presignedInformation = response.data?.presignedGetUrlInfos else {
            log("Presigned URL 응답 데이터 없음")
            return []
        }
        
        log("Presigned URL 요청 완료 - URL 수: \(presignedInformation.count)")
        return presignedInformation
    }
    
    /// Presigned URL 정보와 이미지 Data를 매핑하여 딕셔너리를 생성합니다.
    ///  - Parameters:
    ///    - presignedInformation: 서버로부터 받은 Presigned URL 정보 배열
    ///    - imageDatas: 업로드할 이미지의 파일명 & Data 튜플 배열
    ///  - Returns: Presigned URL을 key로, 이미지 Data를 value로 하는 딕셔너리
    func makePresignedDictionary(
        presignedInformation: [PresignedUrlInformation],
        imageDatas: [(fileName: String, data: Data)]
    ) -> [URL: Data] {
        var dictionary: [URL: Data] = [:]
        
        for (info, imageData) in zip(presignedInformation, imageDatas) {
            if let url = URL(string: info.presignedUrl) {
                dictionary[url] = imageData.data
            }
        }
        
        return dictionary
    }
    
    /// Presigned URL을 통해 S3에 이미지를 업로드합니다.
    ///  - Parameter presignedDictionary: Presigned URL을 key로, 이미지 Data를 value로 하는 딕셔너리
    ///  - Returns: 업로드된 이미지의 S3 URL 배열
    func uploadImages(presignedDictionary: [URL: Data]) async throws -> [URL] {
        log("S3 업로드 시작 - 이미지 수: \(presignedDictionary.count)")
        let imageKeys = try await uploadPhotosService.uploadImages(presignedDictionary)
        log("S3 업로드 완료 - imageKey 수: \(imageKeys.count)")
        return imageKeys
    }
    
    /// S3 URL 배열을 imageKey 문자열 배열로 가공합니다.
    ///  - Parameter imageKeys: 업로드된 이미지의 S3 URL 배열
    ///  - Returns: truncate 처리된 imageKey 문자열 배열
    func makeImageKeyStrings(imageKeys: [URL]) -> [String] {
        return imageKeys.map { $0.absoluteString.truncatedForS3() }
    }
    
    func log(_ text: String) {
        print("📸 [PhotoUploadManager] \(text)")
    }
}
