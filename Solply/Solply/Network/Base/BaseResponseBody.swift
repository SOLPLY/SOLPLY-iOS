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

/// mockData용 응답
extension BaseResponseBody {
    static func mockSuccess(
        data: T,
        message: String = "mock 데이터를 불러오는 데 성공했습니다."
    ) -> BaseResponseBody<T> {

        return BaseResponseBody(
            success: true,
            code: "200",
            message: message,
            data: data
        )
    }
}
