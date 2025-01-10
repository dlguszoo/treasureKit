import UIKit
import SnapKit
// 로딩뷰

extension UIViewController {
    
    private struct AssociatedKeys {
        static var activityIndicator = "snapkitActivityIndicator"
        static var overlayView = "snapkitOverlayView"
    }
    
    /// 인디케이터 배경 오버레이
    private var overlayView: UIView {
        if let overlay = objc_getAssociatedObject(self, &AssociatedKeys.overlayView) as? UIView {
            return overlay
        } else {
            let overlay = UIView()
            overlay.backgroundColor = UIColor.black.withAlphaComponent(0.4)
            overlay.isHidden = true
            objc_setAssociatedObject(self, &AssociatedKeys.overlayView, overlay, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return overlay
        }
    }
    
    /// 재사용 가능한 UIActivityIndicatorView
    private var activityIndicator: UIActivityIndicatorView {
        if let indicator = objc_getAssociatedObject(self, &AssociatedKeys.activityIndicator) as? UIActivityIndicatorView {
            return indicator
        } else {
            let indicator = UIActivityIndicatorView(style: .large)
            indicator.color = .white
            indicator.hidesWhenStopped = true
            objc_setAssociatedObject(self, &AssociatedKeys.activityIndicator, indicator, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return indicator
        }
    }
    
    /// 인디케이터 표시
    func showActivityIndicator() {
        if overlayView.superview == nil {
            setupIndicator()
        }
        
        overlayView.isHidden = false
        activityIndicator.startAnimating()
    }
    
    /// 인디케이터 숨기기
    func hideActivityIndicator() {
        activityIndicator.stopAnimating()
        overlayView.isHidden = true
    }
    
    /// 인디케이터 및 오버레이 설정
    private func setupIndicator() {
        guard overlayView.superview == nil else { return }
        
        // 오버레이 뷰 추가
        view.addSubview(overlayView)
        overlayView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // 인디케이터 추가
        overlayView.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(50) // 크기 설정
        }
    }
}
