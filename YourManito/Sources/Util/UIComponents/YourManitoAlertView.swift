//
//  YourManitoAlertView.swift
//  YourManito
//
//  Created by 이자민 on 4/8/24.
//

import UIKit

class YourManitoAlertView: UIView {
    static let identifier: String = "YourManitoAlertView"
    
    private let alertView: UIView = {
        let view = UIView()
        view.backgroundColor = .main_white
        view.roundCorners(cornerRadius: 40, maskedCorners: [.layerMaxXMinYCorner, .layerMinXMinYCorner])
        return view
    }()
    
    private let iconImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let titleLabel: YourManitoLabel = .init(font: .font(.heading_3), color: .main_black)
    private let subtitleLabel: YourManitoLabel = .init(font: .font(.heading_6), color: .gray1)
    
    private let cancelButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = .gray3
        button.titleLabel?.font = .font(.heading_4)
        button.setTitleColor(.gray1, for: .normal)
        button.makeCornerRound(radius: 24)
        return button
    }()
    
    private let confirmButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = .primary
        button.titleLabel?.font = .font(.heading_4)
        button.setTitleColor(.main_white, for: .normal)
        button.makeCornerRound(radius: 24)
        return button
    }()
    
    private let buttonStackVIew: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        return stackView
    }()


    override init(frame: CGRect) {
        super.init(frame: .zero)
        titleLabel.textAlignment = .center
        subtitleLabel.textAlignment = .center
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implement")
    }
        
    private func setLayout() {
        self.backgroundColor = .main_white
        self.roundCorners(cornerRadius: 40, maskedCorners: [.layerMaxXMinYCorner, .layerMinXMinYCorner])
        self.addSubviews(iconImageView, titleLabel, subtitleLabel, buttonStackVIew)
        iconImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.centerX.equalToSuperview()
            $0.height.width.equalTo(80)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(iconImageView.snp.bottom).offset(24)
            $0.centerX.equalToSuperview()
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
        
        buttonStackVIew.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(54)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(64)
        }
    
        buttonStackVIew.addArrangedSubviews(cancelButton, confirmButton)
    }
    
    func configure(image: UIImage?, title: String?, subtitle: String?, cancelTitle: String?, confirmTitle: String?) {
            iconImageView.image = image
            titleLabel.text = title
            subtitleLabel.text = subtitle
            cancelButton.setTitle(cancelTitle, for: .normal)
            confirmButton.setTitle(confirmTitle, for: .normal)
        }

}
