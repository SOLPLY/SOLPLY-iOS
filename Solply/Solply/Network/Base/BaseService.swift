//
//  BaseService.swift
//  Solply
//
//  Created by 김승원 on 7/4/25.
//

import Foundation

import Moya

class BaseService1<T: BaseTargetType> {
    let provider: MoyaProvider<T>
    
    init(session: Session = .default, plugins: [PluginType] = [MoyaLoggingPlugin()]) {
        self.provider = MoyaProvider<T>(
            session: session,
            plugins: plugins
        )
    }
}

class BaseService<Target: BaseTargetType> {
    
    private let provider: MoyaProvider<Target>
    
    // interceptor 필요하면 이렇게 주입 -> Session(interceptor: Interceptor.shared)
    init(session: Session = .default, plugins: [PluginType] = [MoyaLoggingPlugin()]) {
        self.provider = MoyaProvider<Target>(
            session: session,
            plugins: plugins
        )
    }
    
    /// BaseResponseBody<T>로 감싸진 응답을 디코딩합니다.
    /// - T: ResponseModelType 프로토콜을 준수하는 타입 (응답이 없는 경우 EmptyResponseDTO 사용)
    func request<T: ResponseModelType>(
        with target: Target
    ) async -> Result<BaseResponseBody<T>, NetworkError> {
        await withCheckedContinuation { continuation in
            provider.request(target) { result in
                switch result {
                case .success(let response):
                    switch response.statusCode {
                    case 200...299:
                        do {
                            let decoded = try JSONDecoder().decode(BaseResponseBody<T>.self, from: response.data)
                            continuation.resume(returning: .success(decoded))
                        } catch {
                            continuation.resume(returning: .failure(.responseDecodingError))
                        }
                        
                    case 400, 409:
                        if let errorResponse = try? JSONDecoder().decode(ErrorResponseBody.self, from: response.data) {
                            continuation.resume(returning: .failure(.apiError(message: errorResponse.message)))
                        } else {
                            continuation.resume(returning: .failure(.responseError))
                        }
                        
                    case 401:
                        continuation.resume(returning: .failure(.unauthorized))
                    case 404:
                        continuation.resume(returning: .failure(.notFound))
                    case 500...599:
                        continuation.resume(returning: .failure(.internalServerError))
                    default:
                        continuation.resume(returning: .failure(.responseError))
                    }
                    
                case .failure:
                    continuation.resume(returning: .failure(.networkFail))
                }
            }
        }
    }
}
