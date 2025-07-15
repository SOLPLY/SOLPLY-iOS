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
    let code: String
    let message: String
    let data: T?
}
