// PaddedTextFieldView

import UIKit

open class PaddedTextField: UITextField {
    public var padding: UIEdgeInsets
    
    public init(padding: UIEdgeInsets) {
        self.padding = padding
        super.init(frame: .zero)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    public override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}

//MARK: 사용 예시
//PaddedTextField(padding: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
