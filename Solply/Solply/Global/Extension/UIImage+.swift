//
//  UIImage+.swift
//  Solply
//
//  Created by 김승원 on 10/10/25.
//

import UIKit

extension UIImage {
    /// UIImage를 JPG로 변환 후 파일 이름과 Data를 반환합니다
    /// - Parameter compressionQuality: 0.0 ~ 1.0 (낮을수록 용량 작고 품질 낮음)
    func convertToJPGFile(compressionQuality: CGFloat = 0.8) -> (String, Data)? {
        guard let data = self.jpegData(compressionQuality: compressionQuality) else { return nil }
        let uuid = UUID().uuidString.prefix(8)
        let fileName = "place\(uuid).jpg"
        return (fileName, data)
    }
}
