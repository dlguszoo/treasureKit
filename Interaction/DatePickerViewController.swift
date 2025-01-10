// datepicker 예시 코드
import UIKit
import SnapKit

class DatePickerViewController.swift: UIViewController {
    
    var selectedDate : String?
    
    private lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date // 날짜 선택 모드
        picker.preferredDatePickerStyle = .inline
        picker.tintColor = Constants.Colors.skyblue
        picker.locale = Locale(identifier: "ko_KR") // 한국어로 표시
        picker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        return picker
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        
        setupLayout()
        setDefaultDate()
    }
    
    func setupLayout() {
        // 레이아웃 설정
    }
    
    // MARK: - Actions
    // 선택한 날짜 바뀔 때마다 값 저장
    @objc private func dateChanged(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        selectedDate = formatter.string(from: sender.date)
        
    }
    
    // 아무것도 선택하지 않았을 때, 오늘 날짜로 기본 날짜 설정
    private func setDefaultDate() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let todayString = formatter.string(from: Date())
        
        selectedDate = todayString
    }
    

}
