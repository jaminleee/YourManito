//
//  MakeRoomViewController.swift
//  YourManito
//
//  Created by 이자민 on 3/29/24.
//

import UIKit

final class MakeRoomViewController: UIViewController {
    static let identifier: String = "MakeRoomViewController"
    
    lazy var navigationVarView = YourManitoNavigationBarView(self)
    
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
    
    private let endDateTextField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 16
        textField.layer.borderColor = UIColor.gray3.cgColor
        textField.layer.borderWidth = 2
        textField.layer.backgroundColor = UIColor.gray4.cgColor
        textField.setPlaceholder(placeholder: "종료 날짜", fontColor: .gray2, font: .font(.heading_6))
        textField.setLeftPaddingPoints(20)
        textField.setRightPaddingPoints(20)
        textField.textAlignment = .center
        
        return textField
    }()
    
    private let endTimeTextField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 16
        textField.layer.borderColor = UIColor.gray3.cgColor
        textField.layer.borderWidth = 2
        textField.layer.backgroundColor = UIColor.gray4.cgColor
        textField.setPlaceholder(placeholder: "종료 시간", fontColor: .gray2, font: .font(.heading_6))
        textField.setLeftPaddingPoints(20)
        textField.setRightPaddingPoints(20)
        textField.textAlignment = .center

        return textField
    }()
    
    private let confirmButton: YourManitoButton = .init(title: "확인")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
        setLayout()
        
        roomNameTextField.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingDidBegin)
        roomNameTextField.addTarget(self, action: #selector(changeFont(_:)), for: .valueChanged)
        roomNameTextField.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
        confirmButton.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
        
        let endDatePicker = UIDatePicker()
        endDatePicker.datePickerMode = .date
        endDatePicker.preferredDatePickerStyle = .wheels
        endDatePicker.locale = Locale(identifier: "ko-KR")
        endDatePicker.addTarget(self, action: #selector(dateChange), for: .valueChanged)
        endDateTextField.inputView = endDatePicker
        

        let endTimePicker = UIDatePicker()
        endTimePicker.datePickerMode = .time
        endTimePicker.preferredDatePickerStyle = .wheels
        endTimePicker.locale = Locale(identifier: "ko-KR")
        endTimePicker.addTarget(self, action: #selector(timeChange), for: .valueChanged)
        endTimeTextField.inputView = endTimePicker
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        navigationController?.delegate = self
        
        
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
        self.view.addSubviews(navigationVarView, makeRoomLabel, describeLabel, backgroundView, roomNameLabel, roomNamedescribeLabel, roomNameTextField, endDateLabel, endDatedescribeLabel, endDateTextField, endTimeTextField, confirmButton)
        
        navigationVarView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(26)
            $0.trailing.leading.equalToSuperview()
            $0.height.equalTo(40)
        }
        
        makeRoomLabel.snp.makeConstraints {
            $0.top.equalTo(navigationVarView.snp.bottom).offset(41)
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
        
        endDateTextField.snp.makeConstraints {
            $0.top.equalTo(endDateLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(16)
            $0.width.equalToSuperview().multipliedBy(0.53)
            $0.height.equalTo(68)
        }
        
        endTimeTextField.snp.makeConstraints {
            $0.centerY.equalTo(endDateTextField)
            $0.trailing.equalToSuperview().inset(16)
            $0.width.equalToSuperview().multipliedBy(0.34)
            $0.height.equalTo(68)
        }
        
        confirmButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            $0.height.equalTo(64)
        }
        
    }
    
    @objc private func confirmButtonTapped() {
        let roomCompletionViewController = RoomCompletionViewController()
        navigationController?.pushViewController(roomCompletionViewController, animated: true)
    }
    
    //키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            view.endEditing(true)
        }
    
    @objc func changeFont(_ textField: UITextField) {
        textField.font = .font(.heading_5)
    }
    // 텍스트 필드 선택시 border 색상 변경
    @objc func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = selectedBorderColor
    }

    // 텍스트 필드 선택 해제시 border 색상 변경
    @objc func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = defaultBorderColor
    }
    
    @objc func dateChange(_ sender: UIDatePicker) {
        // 값이 변하면 UIDatePicker에서 날짜를 받아와 형식을 변형해서 textField에 넣어줍니다.
        endDateTextField.text = dateFormat(date: sender.date)
        endDateTextField.font = .font(.heading_5)
    }
    
    @objc func timeChange(_ sender: UIDatePicker) {
        // 값이 변하면 UIDatePicker에서 날짜를 받아와 형식을 변형해서 textField에 넣어줍니다.
        endTimeTextField.text = timeFormat(date: sender.date)
        endTimeTextField.font = .font(.heading_5)
    }
    
    private func dateFormat(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd (E)"
        
        return formatter.string(from: date)
    }
    
    private func timeFormat(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        
        
        return formatter.string(from: date)
    }

}

extension MakeRoomViewController: UINavigationControllerDelegate {

    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        navigationController.interactivePopGestureRecognizer?.isEnabled = navigationController.viewControllers.count > 1
    }
}

extension MakeRoomViewController: UIGestureRecognizerDelegate {
//    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
//        guard gestureRecognizer == interactivePopGestureRecognizer,
//              let topVC = topViewController else {
//            return true // default value
//        }
//        
//        return viewControllers.count > 1 && duringTransition == false && isPopGestureEnable(topVC)
//    }
//    
//    private func isPopGestureEnable(_ topVC: UIViewController) -> Bool {
//        for vc in disabledPopVCs {
//            if String(describing: type(of: topVC)) == String(describing: vc) {
//                return false
//            }
//        }
//        return true
//    }
}
