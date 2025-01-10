// Copyright © 2024 DRINKIG. All rights reserved

import UIKit
import Then
import SnapKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        addView()
        constraints()
    }
    
    func addView() {
        [].forEach{ view.addSubview($0) }
    }
    
    private func constraints() {

    }
}

