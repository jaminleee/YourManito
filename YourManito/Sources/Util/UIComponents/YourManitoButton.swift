//
//  YourManitoButton.swift
//  YourManito
//
//  Created by 이자민 on 4/5/24.
//

import UIKit

class YourManitoButton: UIButton {
    init(title: String) {
        super.init(frame: .zero)
        self.makeCornerRound(radius: 24)
        self.backgroundColor = .primary
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = .font(.heading_4)
        self.setTitleColor(.main_white, for: .normal)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
