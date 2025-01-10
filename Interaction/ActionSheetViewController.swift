// 액션시트 예시 코드
import UIKit
import SnapKit

final class ActionSheetViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUI()
    }
    
    private func setupUI() {
        // 버튼 생성
        let showActionSheetButton = UIButton(type: .system)
        showActionSheetButton.setTitle("Show Action Sheet", for: .normal)
        showActionSheetButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        showActionSheetButton.backgroundColor = .systemBlue
        showActionSheetButton.setTitleColor(.white, for: .normal)
        showActionSheetButton.layer.cornerRadius = 8
        showActionSheetButton.addTarget(self, action: #selector(showActionSheet), for: .touchUpInside)
        
        // 버튼 추가 및 레이아웃 설정
        view.addSubview(showActionSheetButton)
        showActionSheetButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
    }
    
    @objc private func showActionSheet() {
        // 1. Action Sheet 생성
        let actionSheet = UIAlertController(title: "액션시트 타이틀",
                                            message: "어떤 옵션을 선택할건가용",
                                            preferredStyle: .actionSheet)
        
        // 2. 액션 추가
        let optionOne = UIAlertAction(title: "Option 1", style: .default) { _ in
            print("Option 1 selected")
        }
        
        let optionTwo = UIAlertAction(title: "Option 2", style: .default) { _ in
            print("Option 2 selected")
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        // 3. 액션 추가
        actionSheet.addAction(optionOne)
        actionSheet.addAction(optionTwo)
        actionSheet.addAction(cancelAction)
        
        // 4. iPad 대응 (팝오버 위치 설정)
        if let popoverController = actionSheet.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: view.bounds.midX, y: view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        
        // 5. Action Sheet 표시
        present(actionSheet, animated: true, completion: nil)
    }
}
