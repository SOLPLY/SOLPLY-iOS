//
//  UIImage+.swift
//  Solply
//
//  Created by 김승원 on 10/10/25.
//

import UIKit

extension UIImage {
    func convertToPNGFile() -> (String, Data)? {
        guard let data = self.pngData() else { return nil }
        let uuid =  UUID().uuidString.prefix(8)
        let fileName = "place\(uuid).png"
        return (fileName, data)
    }
}
