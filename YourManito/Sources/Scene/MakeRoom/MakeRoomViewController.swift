//
//  MakeRoomViewController.swift
//  YourManito
//
//  Created by 이자민 on 3/29/24.
//

import UIKit

final class MakeRoomViewController: UIViewController {
    static let identifier: String = "MakeRoomViewController"
    
    let selectedBorderColor = UIColor.primary.cgColor
    let defaultBorderColor = UIColor.gray3.cgColor
    
    private let makeRoomLabel: YourManitoLabel = .init(font: .font(.heading_2), color: .main_black)
    private let describeLabel: YourManitoLabel = .init(font: .font(.heading_6), color: .gray1)
    
    private let backgroundView: UIView = {
       let view = UIView()
        view.backgroundColor = .main_white
        view.roundCorners(cornerRadius: 40, maskedCorners: [.layerMaxXMinYCorner, .layerMinXMinYCorner])

        return view
    }()

    private let roomNameLabel: YourManitoLabel = .init(font: .font(.heading_4), color: .main_black)
    private let roomNamedescribeLabel: YourManitoLabel = .init(font: .font(.subtitle_1), color: .gray1)
    
    private let roomNameTextField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 16
        textField.layer.borderColor = UIColor.gray3.cgColor
        textField.layer.borderWidth = 2
        textField.layer.backgroundColor = UIColor.gray4.cgColor
        textField.setPlaceholder(placeholder: "방 이름을 입력해 주세요", fontColor: .gray2, font: .font(.heading_6))
        textField.setLeftPaddingPoints(20)
        textField.setRightPaddingPoints(20)
        //textField.font = .font(.heading_5)
        return textField
    }()
    
    private let endDateLabel: YourManitoLabel = .init(font: .font(.heading_4), color: .main_black)
    private let endDatedescribeLabel: YourManitoLabel = .init(font: .font(.subtitle_1), color: .gray1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
        setLayout()
        
        roomNameTextField.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingDidBegin)
        roomNameTextField.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
        
    }
    
    private func setStyle() {
        self.view.backgroundColor = .gray4
        makeRoomLabel.text = "방 만들기"
        describeLabel.text = "두근두근\n나만의 마니또를 만나러 - !"
        describeLabel.numberOfLines = 2
        roomNameLabel.text = "방 이름"
        roomNamedescribeLabel.text = "최대 15자"
        endDateLabel.text = "종료일"
        endDatedescribeLabel.text = "최대 99일"
        
    }
    
    private func setLayout() {
        self.view.addSubviews(makeRoomLabel, describeLabel, backgroundView, roomNameLabel, roomNamedescribeLabel, roomNameTextField, endDateLabel, endDatedescribeLabel)
        
        makeRoomLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(107)
            $0.leading.equalToSuperview().inset(20)
        }
        
        describeLabel.snp.makeConstraints {
            $0.top.equalTo(makeRoomLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(20)
        }
        
        backgroundView.snp.makeConstraints {
            $0.top.equalTo(describeLabel.snp.bottom).offset(32)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        roomNameLabel.snp.makeConstraints {
            $0.top.equalTo(backgroundView.snp.top).offset(48)
            $0.leading.equalToSuperview().inset(16)
        }
        
        roomNamedescribeLabel.snp.makeConstraints {
            $0.centerY.equalTo(roomNameLabel.snp.centerY)
            $0.leading.equalTo(roomNameLabel.snp.trailing).offset(8)
        }
        
        roomNameTextField.snp.makeConstraints {
            $0.top.equalTo(roomNamedescribeLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(68)
        }
        
        endDateLabel.snp.makeConstraints {
            $0.top.equalTo(roomNameTextField.snp.bottom).offset(40)
            $0.leading.equalToSuperview().inset(16)
        }
        
        endDatedescribeLabel.snp.makeConstraints {
            $0.centerY.equalTo(endDateLabel.snp.centerY)
            $0.leading.equalTo(endDateLabel.snp.trailing).offset(16)
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
