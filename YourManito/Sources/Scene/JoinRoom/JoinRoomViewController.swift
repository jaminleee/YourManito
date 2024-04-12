//
//  JoinRoomViewController.swift
//  YourManito
//
//  Created by 이자민 on 4/6/24.
//

import UIKit

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
    
//    private let deleteAlretView: YourManitoAlertView = {
//       let view = YourManitoAlertView()
//        view.configure(image: .copyGray, title: "삭제할겨?", subtitle: "누르면 삭제됨", cancelTitle: "아니오", confirmTitle: "삭제")
//        return view
//    }()

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
        let dimView = UIView()
        dimView.backgroundColor = UIColor.main_black.withAlphaComponent(0.3)
        dimView.tag = 1
        
        let alertView = YourManitoAlertView()
        alertView.configure(image: .copyGray, title: "삭제할까요?", subtitle: "누르면 삭제됩니다", cancelTitle: "아니오", confirmTitle: "삭제")
        self.view.addSubviews(dimView, alertView)
        dimView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        alertView.tag = 2
        
        alertView.transform = CGAffineTransform(translationX: 0, y: alertView.frame.height)
        UIView.animate(withDuration: 3, animations: {
            alertView.transform = .identity
        })
        
        alertView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.38)
        }
        

        // Dismiss the alert when tapping outside the alert view
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissCustomAlert))
        dimView.addGestureRecognizer(tapGesture)
    }

    @objc private func dismissCustomAlert() {
        let viewWithTag1 = self.view.viewWithTag(1)
        let viewWithTag2 = self.view.viewWithTag(2)
        
        viewWithTag1?.removeFromSuperview()
        viewWithTag2?.removeFromSuperview()
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

