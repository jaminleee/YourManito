//
//  RoomCollectionViewCell.swift
//  YourManito
//
//  Created by 이자민 on 3/28/24.
//

import UIKit
import SnapKit

final class RoomCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "RoomCollectionViewCell"
    
    private let titleStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        
        return stackView
    }()
    
    private let titleLabel: YourManitoLabel = .init(font: .font(.heading_5), color: .main_black)
    private let subTitleLabel: YourManitoLabel = .init(font: .font(.heading_6), color: .gray1)
    
    private let dDayButton: UIButton = {
       let button = UIButton()
        button.setTitle("D-day", for: .normal)
        button.setTitleColor(.primary, for: .normal)
        button.backgroundColor = .sub2
        button.makeCornerRound(radius: 16)
        //button.contentEdgeInsets = .init(top: 4, left: 19, bottom: 4, right: 19)
        
        return button
    }()
    
    private let chevronRightImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .gray2
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        
        contentView.backgroundColor = .main_white
        contentView.layer.cornerRadius = 10
        contentView.addSubviews(titleStackView, dDayButton, chevronRightImageView)
        
        
        titleLabel.text = "Title Label"
        subTitleLabel.text = "SubTitle Label"
        
        titleStackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(24)
        }
        
        titleStackView.addArrangedSubviews(titleLabel, subTitleLabel)
        
        chevronRightImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(15)
            
        }
        
        dDayButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(chevronRightImageView.snp.leading).offset(-23)
            $0.width.equalTo(74)
        }
    }
}
