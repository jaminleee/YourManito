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
    
    private let roomListView: UIView = {
       let view = UIView()
        view.backgroundColor = .gray4
        return view
    }()
    
    private let roomListLabel: YourManitoLabel = .init(font: .font(.heading_3), color: .main_black)
    
    private let roomCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roomCollectionView.delegate = self
        roomCollectionView.dataSource = self
        setStyle()
        setLayout()
        setCollectionViewLayout()
        setCollectionViewConfig()
    }
    
    private func setStyle() {
        self.view.backgroundColor = .white
        roomListLabel.text = "나만의 마니또"
        
        makeRoomButton.addTarget(self, action: #selector(makeRoomButtonTapped), for: .touchUpInside)
        //navigationController?.isNavigationBarHidden = true
    }
    
    
    private func setLayout() {
        self.view.addSubviews(logoImageView, roomStackView, roomListView, roomListLabel, roomCollectionView)
        
        logoImageView.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(32)
            $0.top.equalToSuperview().inset(70)
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
        
        roomListView.snp.makeConstraints {
            $0.top.equalTo(roomStackView.snp.bottom).offset(28)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        roomListLabel.snp.makeConstraints {
            $0.top.equalTo(roomListView.snp.top).offset(44)
            $0.leading.equalToSuperview().inset(32)
        }
        
        roomCollectionView.snp.makeConstraints {
            $0.top.equalTo(roomListLabel.snp.bottom).offset(28)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
    }
    
    @objc private func makeRoomButtonTapped() {
        let makeRoomViewController = MakeRoomViewController()
        navigationController?.pushViewController(makeRoomViewController, animated: true)
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

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RoomCollectionViewCell.identifier, for: indexPath) as? RoomCollectionViewCell
        else {
            print("없슈")
            return UICollectionViewCell()
        }
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width)-32, height: 100)
    }
}
