//
//  YourManitoLabel.swift
//  YourManito
//
//  Created by 이자민 on 3/11/24.
//

import UIKit
final class YourManitoLabel: UILabel {
    init(
        font: UIFont,
        color: UIColor
    ) {
        super.init(frame: .zero)
        self.font = font
        self.textColor = color
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
