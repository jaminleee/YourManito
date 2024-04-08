//
//  RoomCompletionViewController.swift
//  YourManito
//
//  Created by 이자민 on 4/5/24.
//

import UIKit
import SnapKit
import Toast

final class RoomCompletionViewController: UIViewController {
    var daysLeft: Int = 0
    let roomCode: String = "roomdCode"
    private let countdownHeaderLabel: YourManitoLabel = .init(font: .font(.heading_2), color: .main_black)
    private let roomCodeLabel: YourManitoLabel = .init(font: .font(.heading_4), color: .main_black)
    private let roomCodeDescribeLabel: YourManitoLabel = .init(font: .font(.subtitle_1), color: .gray1)
    private lazy var roomCodeButton: UIButton = {
       let button = UIButton()
        var buttonConfiguration = UIButton.Configuration.plain()
        button.makeBorder(width: 3, color: .gray3)
        button.makeCornerRound(radius: 16)
        buttonConfiguration.attributedTitle = AttributedString(roomCode)
        buttonConfiguration.attributedTitle?.font = UIFont.font(.heading_5)
        buttonConfiguration.attributedTitle?.foregroundColor = UIColor.main_black
        buttonConfiguration.image = .copyIcon
        buttonConfiguration.imagePlacement = .trailing
        buttonConfiguration.titlePadding = 20
        buttonConfiguration.titleAlignment = .leading
        buttonConfiguration.imagePadding = 20
        
        button.configuration = buttonConfiguration
        return button
    }()
    
    private let roomCodeView: UIView = {
       let view = UIView()
        view.layer.cornerRadius = 16
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.gray3.cgColor
        return view
    }()
    
    private let roomCodeTitleLabel: YourManitoLabel = .init(font: .font(.heading_5), color: .main_black)
    
    private let copyIconImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = .copyIcon
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let confirmButton: YourManitoButton = .init(title: "공유하기")

    override func viewDidLoad() {
        super.viewDidLoad()

        setStyle()
        setlayout()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(copyRoomCodeToClipboard))
        copyIconImageView.isUserInteractionEnabled = true
        copyIconImageView.addGestureRecognizer(tapGesture)
        confirmButton.addTarget(self, action: #selector(shareRoomCode), for: .touchUpInside)


        
    }
    
    private func setStyle() {
        self.view.backgroundColor = .main_white
        countdownHeaderLabel.numberOfLines = 2
        countdownHeaderLabel.text = "마니또 공개까지\nD-\(daysLeft) 남았어요!"
        roomCodeLabel.text = "방 참여 코드"
        roomCodeTitleLabel.text = roomCode
        roomCodeDescribeLabel.text = "복사해서 공유해보세요!"
    }
    
    private func setlayout() {
        
        self.view.addSubviews(countdownHeaderLabel, roomCodeLabel, roomCodeDescribeLabel, roomCodeView, roomCodeTitleLabel, copyIconImageView, confirmButton)
        
        countdownHeaderLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(107)
            $0.leading.equalToSuperview().inset(16)
        }
        
        roomCodeLabel.snp.makeConstraints {
            $0.top.equalTo(countdownHeaderLabel.snp.bottom).offset(60)
            $0.leading.equalToSuperview().inset(24)
        }
        
        roomCodeDescribeLabel.snp.makeConstraints {
            $0.centerY.equalTo(roomCodeLabel.snp.centerY)
            $0.leading.equalTo(roomCodeLabel.snp.trailing).offset(8)
        }
        
        roomCodeView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(68)
            $0.top.equalTo(roomCodeLabel.snp.bottom).offset(24)
        }
        
        roomCodeTitleLabel.snp.makeConstraints {
            $0.centerY.equalTo(roomCodeView)
            $0.leading.equalTo(roomCodeView.snp.leading).offset(20)
        }
        
        copyIconImageView.snp.makeConstraints {
            $0.centerY.equalTo(roomCodeView)
            $0.trailing.equalTo(roomCodeView.snp.trailing).offset(-20)
            $0.height.width.equalTo(44)
        }
        
        confirmButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(64)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
        }
    }
    
//    @objc private func copyRoomCodeToClipboard() {
//        // Copy roomCode to clipboard
//        UIPasteboard.general.string = roomCode
//        
//        // Display toast message
//        view.makeToast("Room code copied to clipboard", duration: 2.0, position: .bottom)
//    }

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
