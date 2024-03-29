//
//  UIColor+.swift
//  YourManito
//
//  Created by 이자민 on 3/11/24.
//

import UIKit

extension UIColor {
    
    static var primary: UIColor {
        return UIColor(hex: "#883FFF")
    }
    static var sub1: UIColor {
        return UIColor(hex: "#C8B4FF")
    }
    static var sub2: UIColor {
        return UIColor(hex: "#F3EFFF")
    }
    static var gray1: UIColor {
        return UIColor(hex: "#7A7C89")
    }
    static var gray2: UIColor {
        return UIColor(hex: "#ABADB8")
    }
    static var gray3: UIColor {
        return UIColor(hex: "#E6E8F0")
    }
    static var gray4: UIColor {
        return UIColor(hex: "#F7F8FC")
    }
    static var main_black: UIColor {
        return UIColor(hex: "#1B1B1B")
    }
    static var main_white: UIColor {
        return UIColor(hex: "#FFFFFF")
    }
}

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }
        
        assert(hexFormatted.count == 6, "Invalid hex code used.")
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
        
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0, alpha: alpha)
    }
}

