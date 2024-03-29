//
//  UIFont+.swift
//  YourManito
//
//  Created by 이자민 on 3/11/24.
//

import UIKit

enum FontName: String {
    case heading_1, heading_2, heading_3, heading_4, heading_5
    case subtitle_1, subtitle_2, heading_6
    
    var rawValue: String {
        switch self {
        case .heading_1, .heading_2, .heading_3, .heading_4, .heading_5: return "Pretendard-Bold"
        case .subtitle_1, .subtitle_2, .heading_6:
            return "Pretendard-Medium"
        }
    }
    
    var size: CGFloat {
        switch self {
        case .heading_1: return 38
        case .heading_2: return 32
        case .heading_3: return 24
        case .heading_4: return 20
        case .heading_5: return 18
        case .heading_6: return 16
        case .subtitle_1: return 14
        case .subtitle_2: return 12
        }
    }
}

extension UIFont {
    static func font(_ style: FontName) -> UIFont {
        if let font = UIFont(name: style.rawValue, size: style.size) {
            return font
        } else {
            return UIFont.systemFont(ofSize: 20)
        }
    }
}
