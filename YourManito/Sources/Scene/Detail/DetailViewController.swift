//
//  DetailViewController.swift
//  YourManito
//
//  Created by 이자민 on 4/17/24.
//

import UIKit
import SnapKit

final class DetailViewController: UIViewController {
    static let identifier: String = "DetailViewController"
    let myManitoName: String = "마니또"
    
    lazy var navigationVarView = YourManitoNavigationBarView(self)
    
    private let myManitoIsLabel: YourManitoLabel = .init(font: .font(.heading_4), color: .main_black)
    private let myManitoNameLabel: YourManitoLabel = .init(font: .font(.heading_2), color: .main_black)
    
    private let backgroundView: UIView = {
       let view = UIView()
        view.backgroundColor = .main_white
        view.roundCorners(cornerRadius: 40, maskedCorners: [.layerMaxXMinYCorner, .layerMinXMinYCorner])

        return view
    }()
    
    private let sendEncouragementLabel: YourManitoLabel = .init(font: .font(.heading_4), color: .main_black)
    
    private let sendEncouragementDescribeLabel: YourManitoLabel = .init(font: .font(.subtitle_1), color: .gray1)
    
    private let encouragementIconStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        
        return stackView
    }()
    
    private let icon_1: UIImageView = {
       let imageView = UIImageView()
        imageView.image = .icon1Off
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let icon_2: UIImageView = {
       let imageView = UIImageView()
        imageView.image = .icon2Off
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let icon_3: UIImageView = {
       let imageView = UIImageView()
        imageView.image = .icon3Off
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private let icon_4: UIImageView = {
       let imageView = UIImageView()
        imageView.image = .icon4Off
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let sendEncouragementTextField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 16
        textField.layer.borderColor = UIColor.gray3.cgColor
        textField.layer.borderWidth = 2
        textField.layer.backgroundColor = UIColor.gray4.cgColor
        textField.setPlaceholder(placeholder: "응원 메세지 입력", fontColor: .gray2, font: .font(.heading_6))
        textField.setLeftPaddingPoints(20)
        textField.setRightPaddingPoints(20)
        //textField.font = .font(.heading_5)
        return textField
    }()
    
    private let dDayStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 4
        return stackView
    }()
    
    private let dDayLabel: YourManitoLabel = .init(font: .font(.heading_5), color: .gray1)
    
    private let dDayButton: UIButton = {
       let button = UIButton()
        button.setTitle("D-day", for: .normal)
        button.setTitleColor(.primary, for: .normal)
        button.backgroundColor = .sub2
        button.makeCornerRound(radius: 16)
        //button.contentEdgeInsets = .init(top: 4, left: 19, bottom: 4, right: 19)
        
        return button
    }()
    
    private let confirmBtn: YourManitoButton = .init(title: "보내기")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setStyle()
        setLayout()
    }
    
    
    private func setStyle() {
        self.view.backgroundColor = .gray4
        myManitoIsLabel.text = "나의 마니또는"
        myManitoNameLabel.text = "\(myManitoName) 입니다"
        sendEncouragementLabel.text = "응원 보내기!"
        sendEncouragementDescribeLabel.text = "아이콘을 선택하면 추천 멘트가 뜨고, 수정도 가능해요."
        dDayLabel.text = "마니또 공개까지"
        
    }
    
    private func setLayout() {
        self.view.addSubviews(navigationVarView, myManitoIsLabel, myManitoNameLabel, backgroundView, sendEncouragementLabel, sendEncouragementDescribeLabel, encouragementIconStackView, sendEncouragementTextField, dDayStackView, confirmBtn)
        
        
        navigationVarView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(26)
            $0.trailing.leading.equalToSuperview()
            $0.height.equalTo(40)
        }
        
        myManitoIsLabel.snp.makeConstraints {
            $0.top.equalTo(navigationVarView.snp.bottom).offset(41)
            $0.leading.equalToSuperview().inset(20)
        }
        
        myManitoNameLabel.snp.makeConstraints {
            $0.top.equalTo(myManitoIsLabel.snp.bottom).offset(16)
            
            $0.leading.equalTo(myManitoIsLabel.snp.leading)
        }
        
        backgroundView.snp.makeConstraints {
            $0.top.equalTo(myManitoNameLabel.snp.bottom).offset(30)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        sendEncouragementLabel.snp.makeConstraints {
            $0.top.equalTo(backgroundView.snp.top).offset(48)
            $0.leading.equalToSuperview().inset(16)
        }
        
        sendEncouragementDescribeLabel.snp.makeConstraints {
            $0.top.equalTo(sendEncouragementLabel.snp.bottom).offset(8)
            $0.leading.equalTo(sendEncouragementLabel.snp.leading)
        }
        
        encouragementIconStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(sendEncouragementDescribeLabel.snp.bottom).offset(24)
        }
        
        encouragementIconStackView.addArrangedSubviews(icon_1, icon_2, icon_3, icon_4)
        
        sendEncouragementTextField.snp.makeConstraints {
            $0.top.equalTo(encouragementIconStackView.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(68)
        }
        

        confirmBtn.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            $0.height.equalTo(64)
        }
        
        dDayStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(90)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(confirmBtn.snp.top).offset(-20)
    
        }
        
        dDayStackView.addArrangedSubviews(dDayLabel, dDayButton)
        
        dDayButton.snp.makeConstraints {
            $0.width.equalTo(74)
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            view.endEditing(true)
        }
    



}
