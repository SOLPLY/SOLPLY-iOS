//
//  BaseService.swift
//  Solply
//
//  Created by 김승원 on 7/4/25.
//

import Foundation

import Moya

class BaseService<Target: BaseTargetType> {
    
    private let provider: MoyaProvider<Target>
    
    init(
        session: Session = Session(interceptor: TokenInterceptor.shared),
        plugins: [PluginType] = [MoyaLoggingPlugin()]
    ) {
        self.provider = MoyaProvider<Target>(
            session: session,
            plugins: plugins
        )
    }
    
    /// BaseResponseBody<T>로 감싸진 응답을 디코딩합니다.
    /// - T: ResponseModelType 프로토콜을 준수하는 타입 (응답이 없는 경우 EmptyResponseDTO 사용)
    func request<T: ResponseModelType>(
        with target: Target
    ) async throws -> BaseResponseBody<T> {
        try await withCheckedThrowingContinuation { continuation in
            provider.request(target) { result in
                switch result {
                case .success(let response):
                    switch response.statusCode {
                    case 200...299:
                        do {
                            let decoded = try JSONDecoder().decode(BaseResponseBody<T>.self, from: response.data)
                            continuation.resume(returning: decoded)
                        } catch {
                            continuation.resume(throwing: NetworkError.responseDecodingError)
                        }
                        
                    case 400, 409:
                        if let errorResponse = try? JSONDecoder().decode(BaseResponseBody<T>.self, from: response.data) {
                            continuation.resume(throwing: NetworkError.apiError(message: errorResponse.message))
                        } else {
                            continuation.resume(throwing: NetworkError.responseError)
                        }
                        
                    case 401, 403:
                        continuation.resume(throwing: NetworkError.unauthorized)
                    case 404:
                        continuation.resume(throwing: NetworkError.notFound)
                    case 500...599:
                        continuation.resume(throwing: NetworkError.internalServerError)
                    default:
                        continuation.resume(throwing: NetworkError.responseError)
                    }
                    
                case .failure:
                    continuation.resume(throwing: NetworkError.networkFail)
                }
            }
        }
    }

}
