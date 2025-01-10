// Get photo in library or camera

import UIKit
import PhotosUI

class GetPhotoLibrary: UIViewController {
    private let imagePickerManager = ImagePickerManager()
    
    lazy var profileImgFileName: String = ""
    lazy var profileImg: UIImage? = nil
    
    let imageView = UIImageView().then {
        $0.image = UIImage(named: "profilePlaceholder")
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 50
        $0.clipsToBounds = true
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        setupActions()
        configureTapGestureForDismissingPicker()
    }
    
    // MARK: - 이미지 피커 설정
    private func setupImagePicker() {
        imagePickerManager.onImagePicked = { [weak self] image, fileName in
            guard let self = self else { return }
            self.imageView.image = image
            self.profileImgFileName = fileName
            self.profileImg = image
        }
    }
    
    // MARK: UI Component 설정
    func setupUI() {
    }
    
    func setupConstraints() {
    }
    
    func setupActions() {
        imageButton.addTarget(self, action: #selector(selectImage), for: .touchUpInside)
    }
    
    //MARK: Functions
    
    func configureTapGestureForDismissingPicker() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissPicker))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissPicker() {
        view.endEditing(true)
    }
    
    // 이미지 선택
    @objc func selectImage() {
        imagePickerManager.presentImagePicker(from: self)
    }
}


public class ImagePickerManager: NSObject, PHPickerViewControllerDelegate {
    
    // Callback to return the selected image
    public var onImagePicked: ((UIImage, String) -> Void)?

    // Open PHPicker
    public func presentImagePicker(from viewController: UIViewController, selectionLimit: Int = 1) {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images // 이미지 필터
        configuration.selectionLimit = selectionLimit // 선택 제한
        configuration.preferredAssetRepresentationMode = .compatible // 피커 종류
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        viewController.present(picker, animated: true, completion: nil)
    }

    // PHPicker Delegate Method
    public func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)

        guard let result = results.first else { return }

        if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
            result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] object, error in
                guard let self = self else { return }
                if let image = object as? UIImage {
                    let fileName = "\(UUID().uuidString).jpeg"
                    DispatchQueue.main.async {
                        self.onImagePicked?(image, fileName)
                    }
                } else {
                    print("이미지를 불러오지 못했습니다: \(error?.localizedDescription ?? "알 수 없는 오류")")
                }
            }
        } else {
            print("선택한 항목에서 이미지를 로드할 수 없습니다.")
        }
    }
}
