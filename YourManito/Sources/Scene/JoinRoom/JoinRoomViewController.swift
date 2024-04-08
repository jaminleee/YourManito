//
//  JoinRoomViewController.swift
//  YourManito
//
//  Created by 이자민 on 4/6/24.
//

import UIKit
import SwiftEntryKit

final class JoinRoomViewController: UIViewController {
    static let identifier: String = "JoinRoomViewController"
    
    let roomCode: String = "roomdCode"
    let totalMembers: Int = 0
    private let joinRoomTitleLabel: YourManitoLabel = .init(font: .font(.heading_2), color: .main_black)
    private let roomCodeView: UIView = {
       let view = UIView()
        view.backgroundColor = .main_white
        view.makeCornerRound(radius: 16)
        return view
    }()
    private let copyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .copyGray
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private let shareImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .shareGray
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private let roomCodeLabel: YourManitoLabel = .init(font: .font(.heading_6), color: .gray1)

    
    private let backgroundView: UIView = {
       let view = UIView()
        view.backgroundColor = .main_white
        view.roundCorners(cornerRadius: 40, maskedCorners: [.layerMaxXMinYCorner, .layerMinXMinYCorner])

        return view
    }()

    private let totalMembersLabel: YourManitoLabel = .init(font: .font(.heading_4), color: .main_black)
    
    private let describeLabel: YourManitoLabel = .init(font: .font(.heading_6), color: .gray1)
    private let confirmButton: YourManitoButton = .init(title: "확인")
    
    private let membersCollectionView: UICollectionView = {
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
        
        membersCollectionView.delegate = self
        membersCollectionView.dataSource = self
        setStyle()
        setlayout()
        setCollectionViewConfig()
        setCollectionViewLayout()
        
        let tapCopyGesture = UITapGestureRecognizer(target: self, action: #selector(copyRoomCodeToClipboard))
        copyImageView.isUserInteractionEnabled = true
        copyImageView.addGestureRecognizer(tapCopyGesture)
        
        let tapShareGesture = UITapGestureRecognizer(target: self, action: #selector(shareRoomCode))
        shareImageView.isUserInteractionEnabled = true
        shareImageView.addGestureRecognizer(tapShareGesture)

    }
    

    private func setStyle() {
        self.view.backgroundColor = .gray4
        joinRoomTitleLabel.text = "방 이름"
        roomCodeLabel.text = roomCode
        totalMembersLabel.text = "총 \(totalMembers)명"
        describeLabel.text = "참여자가 다 모이면 확인 버튼을 눌러주세요!"
    }
    
    private func setlayout() {
        self.view.addSubviews(joinRoomTitleLabel, roomCodeView, roomCodeLabel, copyImageView, shareImageView, backgroundView, totalMembersLabel, describeLabel, confirmButton, membersCollectionView)
        
        joinRoomTitleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(107)
            $0.leading.equalToSuperview().inset(20)
        }
        
        shareImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.height.width.equalTo(48)
            $0.top.equalTo(joinRoomTitleLabel.snp.bottom).offset(20)
        }
        
        copyImageView.snp.makeConstraints {
            $0.trailing.equalTo(shareImageView.snp.leading).offset(-10)
            $0.height.width.equalTo(48)
            $0.top.equalTo(shareImageView)
        }
        
        roomCodeView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalTo(copyImageView.snp.leading).offset(-16)
            $0.height.equalTo(48)
            $0.centerY.equalTo(shareImageView)
        }
        
        roomCodeLabel.snp.makeConstraints {
            $0.leading.equalTo(roomCodeView.snp.leading).offset(20)
            $0.centerY.equalTo(roomCodeView)
        }
        
        backgroundView.snp.makeConstraints {
            $0.top.equalTo(shareImageView.snp.bottom).offset(30)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        totalMembersLabel.snp.makeConstraints {
            $0.top.equalTo(backgroundView.snp.top).offset(48)
            $0.leading.equalToSuperview().inset(32)
        }
        
        describeLabel.snp.makeConstraints {
            $0.leading.equalTo(totalMembersLabel.snp.leading)
            $0.top.equalTo(totalMembersLabel.snp.bottom).offset(8)
        }
        
        confirmButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            $0.height.equalTo(64)
        }
        
        membersCollectionView.snp.makeConstraints {
            $0.top.equalTo(describeLabel.snp.bottom).offset(20)
            $0.bottom.equalTo(confirmButton.snp.top)
            $0.leading.trailing.equalToSuperview()
        }
    }
    

    
    @objc func presentBottomSheet() {
        func presentBottomSheet(title: String, description: String, image: UIImage, buttonTitle: String, buttonAction: (() -> Void)?) {
            
            var attributes: EKAttributes = .bottomToast
                attributes.roundCorners = .top(radius: 40)
                attributes.displayDuration = .infinity
                attributes.entryInteraction = .absorbTouches
                attributes.screenInteraction = .absorbTouches
            attributes.entryBackground = .color(color: .black)
                
                let titleLabel = EKProperty.LabelContent(
                    text: title,
                    style: EKProperty.LabelStyle(
                        font: .systemFont(ofSize: 18, weight: .semibold),
                        color: EKColor(.white),
                        alignment: .center,
                        numberOfLines: 1
                    )
                )

                let descriptionLabel = EKProperty.LabelContent(
                    text: description,
                    style: EKProperty.LabelStyle(
                        font: .systemFont(ofSize: 16, weight: .regular),
                        color: EKColor(.white),
                        alignment: .center,
                        numberOfLines: 0
                    )
                )
            
            let image = EKProperty.ImageContent(
                image: image,
                size: CGSize(width: 32, height: 32),
                tint: EKColor(.white),
                contentMode: .scaleAspectFill
            )
            
            let buttonLabel = EKProperty.LabelContent(
                text: buttonTitle,
                style: EKProperty.LabelStyle(
                    font: .systemFont(ofSize: 16, weight: .semibold),
                    color: .black,
                    alignment: .center,
                    numberOfLines: 1
                )
            )

             let button = EKProperty.ButtonContent(
                 label: buttonLabel,
                 backgroundColor: .white,
                 highlightedBackgroundColor: .white,
                 contentEdgeInset: 8
             )
            
            let popUpMessage = EKPopUpMessage(
                themeImage: .init(image: image),
                title: titleLabel,
                description: descriptionLabel,
                button: button) {
                    buttonAction?()
                    SwiftEntryKit.dismiss()
                }

            let entry = EKPopUpMessageView(with: popUpMessage)
            SwiftEntryKit.display(entry: entry, using: attributes)
            
        }
        presentBottomSheet(
          title: "This is bottom sheet!",
          description: "You've just created this awesome bottom sheet using SwiftEntryKit!\nLook at this fancy gradient! What a powerfull library!",
          image: UIImage(systemName: "hand.thumbsup")!,
          buttonTitle: "Got it") {
              print("performing some action")
          }
    }
    private func setCollectionViewLayout(){
        let layout = UICollectionViewFlowLayout()
        self.membersCollectionView.setCollectionViewLayout(layout, animated: false)
//        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func setCollectionViewConfig() {
        self.membersCollectionView.register(MembersCollectionViewCell.self, forCellWithReuseIdentifier: MembersCollectionViewCell.identifier)
    }
    
    @objc func copyRoomCodeToClipboard() {
        UIPasteboard.general.string = roomCode
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 172, y: self.confirmButton.frame.minY-65, width: 344, height: 45))
        toastLabel.backgroundColor = .gray3
        toastLabel.textColor = .gray1
        toastLabel.font = .font(.heading_6)
        toastLabel.textAlignment = .center
        toastLabel.text = "코드 복사 완료!"
        toastLabel.layer.cornerRadius = 16
        toastLabel.clipsToBounds  =  true
            
        self.view.addSubview(toastLabel)
            
        UIView.animate(withDuration: 1.0, delay: 0.7, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    @objc func shareRoomCode() {
        var objectsToShare = [String]()
        objectsToShare.append(roomCode)
        
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        
        // 공유하기 기능 중 제외할 기능이 있을 때 사용
//        activityVC.excludedActivityTypes = [UIActivityType.airDrop, UIActivityType.addToReadingList]
        self.present(activityVC, animated: true, completion: nil)
    }
}

extension JoinRoomViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MembersCollectionViewCell.identifier, for: indexPath) as? MembersCollectionViewCell
        else {
            print("없슈")
            return UICollectionViewCell()
        }
        cell.delegate = self
        return cell
    }
}

extension JoinRoomViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width)-48, height: 68)
    }
}

extension JoinRoomViewController: MembersCollectionViewCellDelegate {
    func cellDidTapDelete(in cell: MembersCollectionViewCell) {
        presentBottomSheet()
    }
}

