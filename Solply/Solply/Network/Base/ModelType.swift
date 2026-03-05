//
//  ModelType.swift
//  Solply
//
//  Created by 김승원 on 7/4/25.
//

import Foundation

/// 요청 DTO용
protocol RequestModelType: Encodable {}

/// 응답 DTO용
protocol ResponseModelType: Decodable {}

/// 응답이 필요 없는 경우 사용하는 모델
struct EmptyResponseDTO: ResponseModelType { }
