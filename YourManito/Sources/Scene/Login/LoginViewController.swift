//
//  LoginViewController.swift
//  YourManito
//
//  Created by 이자민 on 2/29/24.
//

import UIKit
import SnapKit

final class LoginViewController: UIViewController {
    static let identifier: String = "LoginViewController"
    
    let selectedBorderColor = UIColor.primary.cgColor
    let defaultBorderColor = UIColor.gray3.cgColor
    
    private let loginLabel: YourManitoLabel = .init(font: .font(.heading_2), color: .main_black)
    private let nicknameLabel: YourManitoLabel = .init(font: .font(.subtitle_1), color: .gray1)
    private let nicknameTextField: UITextField = {
        let textField = UITextField()
        
        textField.layer.cornerRadius = 16
        textField.layer.borderColor = UIColor.gray3.cgColor
        textField.layer.borderWidth = 2
        textField.layer.backgroundColor = UIColor.gray4.cgColor
        textField.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingDidBegin)
        textField.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
        textField.setPlaceholder(placeholder: "한글, 영문 2자 이상", fontColor: .gray2, font: .font(.heading_6))
        textField.setLeftPaddingPoints(20)
        textField.setRightPaddingPoints(20)
        //textField.font = .font(.heading_5)
        
        
        
        return textField
    }()
    
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
    private let confirmButton: UIButton = {
        let button = UIButton()
        button.makeCornerRound(radius: 24)
        button.backgroundColor = .primary
        button.setTitle("확인", for: .normal)
        button.titleLabel?.font = .font(.heading_4)
        button.setTitleColor(.main_white, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setStyle()
        setValue()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        // 키보드 사라짐을 감지하는 옵저버 등록
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setStyle() {
        self.view.backgroundColor = .main_white
        loginLabel.text = "닉네임을 입력하세요"
        nicknameLabel.text = "닉네임"
    }
    
    private func setValue() {
        self.view.addSubviews(loginLabel, nicknameLabel, nicknameTextField, confirmButton)
        
        loginLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(107)
            $0.leading.equalToSuperview().inset(16)
        }
        
        nicknameLabel.snp.makeConstraints {
            $0.top.equalTo(loginLabel.snp.bottom).offset(58)
            $0.leading.equalToSuperview().inset(24)
        }
        
        nicknameTextField.snp.makeConstraints {
            $0.top.equalTo(nicknameLabel.snp.bottom).offset(9)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(68)
        }
        
        confirmButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            $0.height.equalTo(64)
        }
        
    }
    
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        
        let keyboardHeight = keyboardFrame.height
        let animationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval ?? 0.3
        
        UIView.animate(withDuration: animationDuration) {
            self.confirmButton.snp.updateConstraints {
                $0.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-keyboardHeight - 20)
            }
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let animationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else {
            return
        }
        
        UIView.animate(withDuration: animationDuration) {
            self.confirmButton.snp.updateConstraints {
                $0.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-20)
            }
            self.view.layoutIfNeeded()
        }
    }
    
    deinit {
        // 옵저버 등록 해제
        NotificationCenter.default.removeObserver(self)
    }
    
    
    
}
