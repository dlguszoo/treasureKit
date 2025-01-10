import UIKit

final class IndicatorExViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUI()
    }
    
    private func setupUI() {
        // 버튼 생성
        let toggleButton = UIButton(type: .system)
        toggleButton.setTitle("Toggle Activity Indicator", for: .normal)
        toggleButton.backgroundColor = .systemBlue
        toggleButton.setTitleColor(.white, for: .normal)
        toggleButton.layer.cornerRadius = 8
        toggleButton.addTarget(self, action: #selector(toggleIndicator), for: .touchUpInside)
        
        view.addSubview(toggleButton)
        toggleButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
    }
    
    @objc private func toggleIndicator() {
        if activityIndicatorIsVisible {
            hideActivityIndicator()
        } else {
            showActivityIndicator()
            
            // 3초 후 자동으로 숨기기
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.hideActivityIndicator()
            }
        }
    }
    
    private var activityIndicatorIsVisible: Bool {
        !(overlayView?.isHidden ?? true)
    }
}
