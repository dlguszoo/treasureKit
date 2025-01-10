// 커스텀 네비게이션 바
// VC 에서 NavigationBarManager 호출
// setupNavBar 함수에서 func 호출

import Foundation
import UIKit

class NavigationBarManager {
    
    init() {
        }
    
    // MARK: - 왼쪽 커스텀 백버튼 생성
    func addBackButton(to navigationItem: UINavigationItem, target: Any?, action: Selector, tintColor: UIColor ?? .systemgray) {
        let backButton = UIButton(type: .system)
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButton.tintColor = tintColor
        backButton.addTarget(target, action: action, for: .touchUpInside)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    // MARK: - 네비게이션 타이틀 설정
    func setTitle(to navigationItem: UINavigationItem, title: String, textColor: UIColor = .label, font: UIFont = .systemFont(ofSize: 18, weight: .medium))) {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = font
        titleLabel.textColor = textColor
        titleLabel.textAlignment = .center
        navigationItem.titleView = titleLabel
    }
    
    // MARK: - 오른쪽 커스텀 버튼 생성
    func addRightButton(
        to navigationItem: UINavigationItem,
        title: String? = nil,
        icon: String? = nil,
        target: Any?,
        action: Selector,
        tintColor: UIColor = .label,
        font: UIFont = .systemFont(ofSize: 16, weight: .medium)
    ) {
        let rightButton = UIButton(type: .system)
        
        if let title = title {
            // 텍스트 버튼
            rightButton.setTitle(title, for: .normal)
            rightButton.setTitleColor(tintColor, for: .normal)
            rightButton.titleLabel?.font = font
        } else if let icon = icon {
            // 이미지 버튼
            rightButton.setImage(UIImage(systemName: icon), for: .normal)
            rightButton.tintColor = tintColor
        }
        
        rightButton.addTarget(target, action: action, for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton)
    }
}
