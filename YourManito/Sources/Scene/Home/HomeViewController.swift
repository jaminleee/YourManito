//
//  HomeViewController.swift
//  YourManito
//
//  Created by 이자민 on 2/26/24.
//

import UIKit
import SnapKit

final class HomeViewController: UIViewController {
    
    private let testLabel: YourManitoLabel = .init(font: .font(.heading_1), color: .black)

    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        self.view.backgroundColor = .white
        testLabel.text = "너마니또"
    }
    
    private func setLayout() {
        self.view.addSubview(testLabel)
        testLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(32)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(27)
        }
    }
}

