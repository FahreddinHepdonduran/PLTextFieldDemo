//
//  PLTextField.swift
//  PLTextFieldDemo
//
//  Created by fahreddin on 21.06.2022.
//

import UIKit

final class PLTextField: UIView {
    
    // MARK: - Subviews
    private lazy var textfield: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.textColor = .black
        textfield.layer.borderWidth = 2.0
        textfield.layer.borderColor = UIColor.black.cgColor
        return textfield
    }()
    
    private lazy var floatingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    
    // MARK: - Stored Properties
    private var placeholder: String = ""
    private var validationRule: ((String) -> String?)?
    private var placeholderColor: UIColor?
    private var alertTextColor: UIColor?
    
    // MARK: - Floating Label Constraint
    private var floatingLabelCenterYConstraintToPLTextFieldCenterY: NSLayoutConstraint!
    private var floatingLabelTopConstraintToTextFieldBottom: NSLayoutConstraint!
    
    // MARK: - TextField First Tap Flag
    private var isFirstTime: Bool = true
    
    // MARK: - Set Validation Rule
    var setValidationRule: ((String) -> String?)? {
        didSet {
            guard let validationRule = setValidationRule else {return}
            self.validationRule = validationRule
        }
    }
    
    // MARK: - Configure TextField And Label
    var setPlaceholder: String? {
        didSet {
            guard let placeholder = setPlaceholder else {return}
            floatingLabel.text = placeholder
            self.placeholder = placeholder
        }
    }
    
    var setBorderColor: UIColor? {
        didSet {
            guard let color = setBorderColor else {return}
            textfield.layer.borderColor = color.cgColor
        }
    }
    
    var setPlaceholderColor: UIColor? {
        didSet {
            guard let color = setPlaceholderColor else {return}
            floatingLabel.textColor = color
            placeholderColor = color
        }
    }
    
    var setAlertTextColor: UIColor? {
        didSet {
            guard let color = setAlertTextColor else {return}
            alertTextColor = color
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addTextFieldConstraints()
        addFloatingLabelConstraints()
        setTextFieldDelegate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - UITextField Delegate Extensions

extension PLTextField: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newLength = (textfield.text?.count ?? 0) + (string.count) - (range.length)
        if newLength == 0 {
            hideFloatingLabel()
            isFirstTime = !isFirstTime
            floatingLabel.text = placeholder
            floatingLabel.textColor = placeholderColor ?? UIColor.black
            return true
        }
        
        if let text = textField.text as NSString? {
            let updatedText = text.replacingCharacters(in: range, with: string)
            validateText(text: updatedText)
        }

        return true
    }
    
}

// MARK: - Private Extensions

private extension PLTextField {
    
    func setTextFieldDelegate() {
        textfield.delegate = self
    }
    
    func addTextFieldConstraints() {
        addSubview(textfield)
        
        NSLayoutConstraint.activate([
            textfield.topAnchor.constraint(equalTo: self.topAnchor),
            textfield.leftAnchor.constraint(equalTo: self.leftAnchor),
            textfield.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            textfield.rightAnchor.constraint(equalTo: self.rightAnchor)
        ])
    }
    
    func addFloatingLabelConstraints() {
        insertSubview(floatingLabel, belowSubview: textfield)
        
        NSLayoutConstraint.activate([
            floatingLabel.leftAnchor.constraint(equalTo: self.leftAnchor),
            floatingLabel.rightAnchor.constraint(equalTo: self.rightAnchor),
            floatingLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5),
            floatingLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
        floatingLabelTopConstraintToTextFieldBottom = floatingLabel.topAnchor.constraint(equalTo: self.bottomAnchor)
        
        floatingLabelCenterYConstraintToPLTextFieldCenterY = floatingLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        floatingLabelCenterYConstraintToPLTextFieldCenterY.isActive = true
    }
    
    func hideFloatingLabel() {
        UIView.animate(withDuration: 0.2, delay: 0, options: []) { [weak self] in
            self?.floatingLabelTopConstraintToTextFieldBottom.isActive = false
            self?.floatingLabelCenterYConstraintToPLTextFieldCenterY.isActive = true
            self?.layoutIfNeeded()
        }
    }
    
    func showFloatingLabel() {
        UIView.animate(withDuration: 0.2, delay: 0, options: []) { [weak self] in
            self?.floatingLabelCenterYConstraintToPLTextFieldCenterY.isActive = false
            self?.floatingLabelTopConstraintToTextFieldBottom.isActive = true
            self?.layoutIfNeeded()
        }
    }
    
    func validateText(text: String) {
        guard let validationRule = self.validationRule else {return}
        
        if let alertText = validationRule(text) {
            if isFirstTime {
                showFloatingLabel()
                isFirstTime = !isFirstTime
                floatingLabel.text = alertText
                floatingLabel.textColor = alertTextColor ?? UIColor.red
            }
        } else {
            if !isFirstTime {
                hideFloatingLabel()
                isFirstTime = !isFirstTime
                floatingLabel.text = ""
            }
        }
    }
    
}
