//
//  TokenError.swift
//  Solply
//
//  Created by sun on 9/12/25.
//

import Foundation

enum TokenError: Error {
    case noRefreshToken
    case reissueFailed
    case refreshTokenExpired
    case userNotFound
    case serverError
    case decodingFailed
    case unknown(error: Error)

    var description: String {
        switch self {
        case .noRefreshToken:
            return "저장된 refreshToken이 없습니다."
        case .reissueFailed:
            return "토큰 재발급 요청에 실패했습니다."
        case .refreshTokenExpired:
            return "refreshToken이 만료되었습니다."
        case .userNotFound:
            return "해당 유저를 찾을 수 없습니다."
        case .serverError:
            return "서버 오류가 발생했습니다."
        case .decodingFailed:
            return "응답 디코딩에 실패했습니다."
        case .unknown(let error):
            return "알 수 없는 오류가 발생했습니다: \(error.localizedDescription)"
        }
    }
}
