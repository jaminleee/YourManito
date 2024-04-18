//
//  YourManitoNavigationBar.swift
//  YourManito
//
//  Created by 이자민 on 4/12/24.
//

import UIKit
import SnapKit

final class YourManitoNavigationBarView: UIView {
    private let arrowButton: UIButton = {
        let button = UIButton()
        button.setImage(.chevronIcon, for: .normal)
        button.addTarget(self, action: #selector(arrowButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    var titleLabel: YourManitoLabel = .init(font: .font(.heading_5), color: .main_black)
    
    private weak var viewController: UIViewController?
    
    init(_ viewController: UIViewController) {
        self.viewController = viewController
        super.init(frame: .zero)
        setLayout()
        self.backgroundColor = .clear
        titleLabel.textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

private extension YourManitoNavigationBarView {
    private func setLayout() {
        self.addSubviews(arrowButton, titleLabel)
        
        arrowButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(12)
            $0.size.equalTo(40)
            $0.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        // 스와이프 제스처 추가
//        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
//        swipeGesture.direction = .right
//        self.addGestureRecognizer(swipeGesture)
    }
}
    
    
extension YourManitoNavigationBarView {
    @objc
    private func arrowButtonTapped() {
        self.viewController?.navigationController?.popViewController(animated: true)
    }
}
