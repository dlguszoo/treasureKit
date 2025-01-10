// CustomTextFieldView

import UIKit
import SnapKit

class CustomTextFieldView: UIView, UITextFieldDelegate {
    
    // MARK: - Properties
    let textField: PaddedTextField
    private let validationLabel: UILabel
    
    /// 텍스트 필드의 텍스트
    var text: String? {
        return textField.text
    }
    
    // MARK: - Initializer
    init(
        textFieldPlaceholder: String,
        validationText: String
    ) {
        self.textField = PaddedTextField(padding: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
        self.validationLabel = UILabel()
        super.init(frame: .zero)
        setupUI(
            placeholder: textFieldPlaceholder,
            validationText: validationText
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI
    private func setupUI(placeholder: String, validationText: String) {
        
        // 텍스트 필드 설정
        textField.placeholder = placeholder
        textField.borderStyle = .none
        textField.font = UIFont.systemFont(ofSize: 14, weight: .semibold) // 대체 가능한 폰트 설정
        textField.backgroundColor = .white
        textField.delegate = self
        
        //텍스트 필드 보더 설정
//        textField.layer.borderColor = UIColor
//        textField.layer.borderWidth = CGFloat
//        textField.layer.cornerRadius = CGFloat
        
        // Placeholder 색상 설정
        let placeholderColor = AppColor.gray70 ?? UIColor.systemGray
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: placeholderColor]
        )
        
        // 검증 라벨 설정
        validationLabel.text = validationText
        validationLabel.textColor = .red
        validationLabel.font = UIFont.systemFont(ofSize: 12)
        validationLabel.isHidden = true
        
        // UI 구성
        addSubview(textField)
        addSubview(validationLabel)
        
        // 제약 조건 설정
        textField.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(50)
        }
        validationLabel.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(5)
            make.leading.equalToSuperview().inset(8)
        }
    }
    
    // MARK: - Update Validation
    /// 검증 라벨의 텍스트와 상태 업데이트
    func updateValidationText(
        _ text: String,
        isHidden: Bool,
        color: UIColor? = .red
    ) {
        validationLabel.text = text
        validationLabel.isHidden = isHidden
        validationLabel.textColor = color
    }
}
