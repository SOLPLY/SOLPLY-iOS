//
//  BaseResponseBody.swift
//  Solply
//
//  Created by 김승원 on 7/4/25.
//

import Foundation

/// 공통 응답 DTO
struct BaseResponseBody<T: ResponseModelType>: ResponseModelType {
    let code: Int
    let message: String
    // TODO: 서버에서 nullable인지 확인 후 수정 필요
    let data: T?
}

/// 에러 응답 DTO
struct ErrorResponseBody: ResponseModelType {
    let code: Int
    let message: String
    // TODO: 서버에서 error상황에서
}
