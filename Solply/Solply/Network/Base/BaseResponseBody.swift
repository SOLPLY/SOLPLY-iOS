//
//  BaseResponseBody.swift
//  Solply
//
//  Created by 김승원 on 7/4/25.
//

import Foundation

/// 공통 응답 DTO
struct BaseResponseBody<T: ResponseModelType>: ResponseModelType {
    let success: Bool
    let code: Int
    let message: String
    let data: T?
}

// TODO: 일단 주석 해놓을게예
/// 에러 응답 DTO
//struct ErrorResponseBody<T: ResponseModelType>: ResponseModelType {
//    let success: Bool
//    let code: Int
//    let message: String
//    let data: T?
//}
