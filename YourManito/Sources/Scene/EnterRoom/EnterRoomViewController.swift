//
//  EnterRoomViewController.swift
//  YourManito
//
//  Created by 이자민 on 4/6/24.
//

import UIKit

final class EnterRoomViewController: UIViewController {
    static let identifier: String = "EnterRoomViewController"
    
    let selectedBorderColor = UIColor.primary.cgColor
    let defaultBorderColor = UIColor.gray3.cgColor
    
    private let enterRoomLabel: YourManitoLabel = .init(font: .font(.heading_2), color: .main_black)
    private let describeLabel: YourManitoLabel = .init(font: .font(.heading_6), color: .gray1)
    
    private let backgroundView: UIView = {
       let view = UIView()
        view.backgroundColor = .main_white
        view.roundCorners(cornerRadius: 40, maskedCorners: [.layerMaxXMinYCorner, .layerMinXMinYCorner])

        return view
    }()

    private let roomCodeLabel: YourManitoLabel = .init(font: .font(.heading_4), color: .main_black)
    private let roomCodedescribeLabel: YourManitoLabel = .init(font: .font(.subtitle_1), color: .gray1)
    
    private let roomCodeTextField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 16
        textField.layer.borderColor = UIColor.gray3.cgColor
        textField.layer.borderWidth = 2
        textField.layer.backgroundColor = UIColor.gray4.cgColor
        textField.setPlaceholder(placeholder: "참여 코드", fontColor: .gray2, font: .font(.heading_6))
        textField.setLeftPaddingPoints(20)
        textField.setRightPaddingPoints(20)
        //textField.font = .font(.heading_5)
        return textField
    }()
    
    private let confirmButton: YourManitoButton = .init(title: "확인")

    override func viewDidLoad() {
        super.viewDidLoad()

        setStyle()
        setLayout()
        
        roomCodeTextField.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingDidBegin)
        roomCodeTextField.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
        
    }
    private func setStyle() {
        self.view.backgroundColor = .gray4
        enterRoomLabel.text = "방 입장하기"
        describeLabel.text = "두근두근\n나만의 마니또를 만나러 - !"
        describeLabel.numberOfLines = 2
        roomCodeLabel.text = "방 참여코드"
        roomCodedescribeLabel.text = "방장에게 받은 참여 코드를 입력해주세요"
        
    }
    
    private func setLayout() {
        self.view.addSubviews(enterRoomLabel, describeLabel, backgroundView, roomCodeLabel, roomCodedescribeLabel, roomCodeTextField, confirmButton)
        
        enterRoomLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(107)
            $0.leading.equalToSuperview().inset(20)
        }
        
        describeLabel.snp.makeConstraints {
            $0.top.equalTo(enterRoomLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(20)
        }
        
        backgroundView.snp.makeConstraints {
            $0.top.equalTo(describeLabel.snp.bottom).offset(32)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        roomCodeLabel.snp.makeConstraints {
            $0.top.equalTo(backgroundView.snp.top).offset(48)
            $0.leading.equalToSuperview().inset(16)
        }
        
        roomCodedescribeLabel.snp.makeConstraints {
            $0.leading.equalTo(roomCodeLabel.snp.leading)
            $0.top.equalTo(roomCodeLabel.snp.bottom).offset(8)
        }
        
        roomCodeTextField.snp.makeConstraints {
            $0.top.equalTo(roomCodedescribeLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(68)
        }
        
        confirmButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            $0.height.equalTo(64)
        }
    }

    //키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            view.endEditing(true)
        }
    
    // 텍스트 필드 선택시 border 색상 변경
    @objc func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = selectedBorderColor
    }

    // 텍스트 필드 선택 해제시 border 색상 변경
    @objc func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = defaultBorderColor
    }

}
