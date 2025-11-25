//
//  UIScreenScaler.swift
//  Solply
//
//  Created by 김승원 on 6/27/25.
//

import SwiftUI

extension CGFloat {
    var adjustedWidth: CGFloat {
        let ratio: CGFloat = UIScreen.main.bounds.width / 375
        return self * ratio
    }
    
    var adjustedHeight: CGFloat {
        let ratio: CGFloat = UIScreen.main.bounds.height / 812
        return self * ratio
    }
    
    var adjusted: CGFloat {
        let ratio: CGFloat = UIScreen.main.bounds.width / 375
        return self * ratio
    }
}

extension Double {
    var adjustedWidth: Double {
        let ratio: Double = Double(UIScreen.main.bounds.width / 375)
        return self * ratio
    }
    
    var adjustedHeight: Double {
        let ratio: Double = Double(UIScreen.main.bounds.height / 812)
        return self * ratio
    }
    
    var adjusted: Double {
        let ratio: Double = Double(UIScreen.main.bounds.width / 375)
        return self * ratio
    }
}

extension Int {
    var adjustedWidth: CGFloat {
        return CGFloat(self).adjustedWidth
    }
    
    var adjustedHeight: CGFloat {
        return CGFloat(self).adjustedHeight
    }
    
    var adjusted: CGFloat {
        return CGFloat(self).adjustedWidth
    }
}
