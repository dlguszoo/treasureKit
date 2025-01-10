// RoundImageView

import UIKit
import SnapKit

class RoundImageView: UIView {
    
    // MARK: - Properties
    private let size: CGFloat
    private let profileImageView = UIImageView()
    
    // MARK: - Initializer
    init(size: CGFloat, image: UIImage? = UIImage(named: "profilePlaceholder")) {
        self.size = size
        super.init(frame: .zero)
        setupUI(image: image)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func setupUI(image: UIImage?) {
        profileImageView.image = image
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = size / 2
        profileImageView.clipsToBounds = true
        
        self.addSubview(profileImageView)
        profileImageView.snp.makeConstraints { make in
            make.width.height.equalTo(size)
            make.center.equalToSuperview()
        }
    }
}

//MARK: 사용 예시
//let roundImageView = RoundImageView(size: 100, image: UIImage(named: "customProfileImage"))
