//
//  UIStackView+.swift
//  YourManito
//
//  Created by 이자민 on 3/11/24.
//

import UIKit

extension UIStackView {
    
    func addArrangedSubviews(_ views: UIView...) {
        for view in views {
            self.addArrangedSubview(view)
        }
    }
    
}
