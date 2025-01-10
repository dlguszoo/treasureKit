// 커스텀 버튼

import Foundation

import UIKit
import SnapKit

class CustomButton: UIButton {
    
    // MARK: - Properties
    /// 버튼 활성화 상태에서의 기본 배경색
    private var originalBackgroundColor: UIColor = .systemBlue
    
    // MARK: - Initializer
    init(
        backgroundColor: UIColor = .systemBlue,
        title: String = "",
        titleColor: UIColor = .black,
        radius: CGFloat? = nil,
        isEnabled: Bool? = nil
    ) {
        super.init(frame: .zero)
        configureButton(
            title: title,
            titleColor: titleColor,
            radius: radius ?? 10,
            backgroundColor: backgroundColor,
            isEnabled: isEnabled ?? true
        )
        setDefaultHeight(60)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    /// 버튼 설정 업데이트
    func configure(
        title: String,
        titleColor: UIColor,
        radius: CGFloat?,
        backgroundColor: UIColor,
        isEnabled: Bool?
    ) {
        configureButton(
            title: title,
            titleColor: titleColor,
            radius: radius ?? 10,
            backgroundColor: backgroundColor,
            isEnabled: isEnabled ?? true
        )
    }
    
    /// 버튼 활성화 상태 업데이트
    func setEnabled(_ isEnabled: Bool?) {
        self.isEnabled = isEnabled ?? true
        updateBackgroundColor()
    }
    
    // MARK: - Private Helper Methods
    private func configureButton(
        title: String,
        titleColor: UIColor,
        radius: CGFloat,
        backgroundColor: UIColor,
        isEnabled: Bool
    ) {
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        self.layer.cornerRadius = radius
        self.originalBackgroundColor = backgroundColor
        self.isEnabled = isEnabled
        updateBackgroundColor()
    }
    
    private func updateBackgroundColor() {
        self.backgroundColor = self.isEnabled ? originalBackgroundColor : .gray
    }
    
    private func setDefaultHeight(_ height: CGFloat) {
        self.snp.makeConstraints { make in
            make.height.equalTo(height)
        }
    }
}

// MARK: 버튼 사용 예시
//// 버튼 생성
//let button = CustomButton(
//    backgroundColor: .systemBlue,
//    title: "확인",
//    titleColor: .white,
//    radius: 12,
//    isEnabled: true
//)
//
//// 버튼 구성 업데이트
//button.configure(
//    title: "취소",
//    titleColor: .red,
//    radius: nil,
//    backgroundColor: .systemGray,
//    isEnabled: false
//)
//
//// 활성화 상태 변경
//button.setEnabled(true)
