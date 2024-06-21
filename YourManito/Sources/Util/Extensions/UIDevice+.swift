//
//  UIDevice+.swift
//  YourManito
//
//  Created by 이자민 on 5/27/24.
//

import Foundation
import UIKit

extension UIDevice {
    var deviceUUID: String {
        return identifierForVendor?.uuidString ?? "unknown"
    }
}
