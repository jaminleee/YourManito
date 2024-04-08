//
//  membersCollectionViewCell.swift
//  YourManito
//
//  Created by 이자민 on 4/6/24.
//

import UIKit

protocol MembersCollectionViewCellDelegate: AnyObject {
    func cellDidTapDelete(in cell: MembersCollectionViewCell)
}

final class MembersCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "MembersCollectionViewCell"
    weak var delegate: MembersCollectionViewCellDelegate?
    
    private let nameLabel: YourManitoLabel = .init(font: .font(.heading_5), color: .main_black)
    private let deleteImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = .deleteIcon
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
        nameLabel.text = "name"
        
        let tapCopyGesture = UITapGestureRecognizer(target: self, action: #selector(deleteButtonTapped))
        deleteImageView.isUserInteractionEnabled = true
        deleteImageView.addGestureRecognizer(tapCopyGesture)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        contentView.backgroundColor = .main_white
        contentView.layer.cornerRadius = 16
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor.gray3.cgColor
        contentView.addSubviews(nameLabel, deleteImageView)
        
        nameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }
        
        deleteImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }
        
    }
    
    @objc private func deleteButtonTapped() {
        delegate?.cellDidTapDelete(in: self)
        print("클릭")
    }
    
}
