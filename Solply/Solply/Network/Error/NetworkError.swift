//
//  NetworkError.swift
//  Solply
//
//  Created by 김승원 on 7/4/25.
//

import Foundation

enum NetworkError: Error {
    case apiError(message: String) // 서버의 도메인 에러 메시지
    case unauthorized // 401: 인증 실패
    case notFound // 404: 리소스 없음
    case internalServerError // 500: 서버 오류
    case responseError // 기타 4xx, 5xx
    case responseDecodingError // JSON 디코딩 실패
    case networkFail // 인터넷 연결 실패 등
    case unknownError // 알 수 없는 에러
}

extension NetworkError: CustomStringConvertible {
    var description: String {
        switch self {
        case .apiError(let message): return "API 에러입니다: \(message)"
        case .unauthorized: return "인증이 필요합니다."
        case .notFound: return "요청한 리소스를 찾을 수 없습니다."
        case .internalServerError: return "서버 내부 오류가 발생했습니다."
        case .responseError: return "서버로부터 오류 응답을 받았습니다."
        case .responseDecodingError: return "응답 데이터를 디코딩하는 데 실패했습니다."
        case .networkFail: return "네트워크 연결에 실패했습니다. 인터넷 상태를 확인해주세요."
        case .unknownError: return "알 수 없는 에러가 발생했습니다."
        }
    }
}
