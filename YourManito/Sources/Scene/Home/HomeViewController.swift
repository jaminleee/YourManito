//
//  HomeViewController.swift
//  YourManito
//
//  Created by 이자민 on 2/26/24.
//

import UIKit
import SnapKit

final class HomeViewController: UIViewController {
    static let identifier: String = "HomeViewController"
    
    
    private let testLabel: YourManitoLabel = .init(font: .font(.heading_1), color: .black)
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "smallLogo")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private let makeRoomButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .sub2
        button.makeCornerRound(radius: 24)
        button.setTitle("방 만들기", for: .normal)
        button.titleLabel?.font = UIFont.font(.heading_5)
        button.setTitleColor(.main_black, for: .normal)
        return button
    }()


    private let joinRoomButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .sub2
        button.makeCornerRound(radius: 24)
        button.setTitle("방 입장하기", for: .normal)
        button.titleLabel?.font = UIFont.font(.heading_5)
        button.setTitleColor(.main_black, for: .normal)
        
        return button
    }()

    private let roomStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let roomCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .gray4
        
        return collectionView
    }()
    
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
        self.view.addSubviews(logoImageView, roomStackView, roomCollectionView)
        
        logoImageView.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(32)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(27)
            $0.height.equalTo(40)
            $0.width.equalTo(130)
        }
        
        roomStackView.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().inset(16)
        }
        
        roomStackView.addArrangedSubviews(makeRoomButton, joinRoomButton)
        
        makeRoomButton.snp.makeConstraints {
            $0.height.equalTo((UIScreen.main.bounds.width-24) / 164 * 65)
        }
        
        roomCollectionView.snp.makeConstraints {
            $0.top.equalTo(roomStackView.snp.bottom).offset(28)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
    }
    
    private func setCollectionViewLayout(){
        let layout = UICollectionViewFlowLayout()
        self.roomCollectionView.setCollectionViewLayout(layout, animated: false)
//        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func setCollectionViewConfig() {
        self.roomCollectionView.register(RoomCollectionViewCell.self, forCellWithReuseIdentifier: RoomCollectionViewCell.identifier)
    }
}

