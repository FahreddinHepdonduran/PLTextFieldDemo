//
//  ViewController.swift
//  PLTextFieldDemo
//
//  Created by fahreddin on 21.06.2022.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.spacing = 10
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addPLTextField()
        addStackView()
    }
    
    func addPLTextField() {
        let textfield1 = PLTextField()
        textfield1.translatesAutoresizingMaskIntoConstraints = false
        textfield1.heightAnchor.constraint(equalToConstant: 50).isActive = true
        textfield1.setPlaceholder = "Email"
        textfield1.setValidationRule = { text in
            return text.count >= 4 ? nil : "invalid email"
        }
        textfield1.setBorderColor = UIColor.black
        textfield1.setPlaceholderColor = UIColor.black
        textfield1.setAlertTextColor = UIColor.red
        
        let textfield2 = PLTextField()
        textfield2.setPlaceholder = "Password"
        textfield2.setValidationRule = { text in
            return text.count >= 4 ? nil : "invalid email"
        }
        textfield2.setBorderColor = UIColor.blue
        textfield2.setPlaceholderColor = UIColor.green
        textfield2.setAlertTextColor = UIColor.green
        
        let textfield3 = PLTextField()
        textfield3.setPlaceholder = "Name"
        textfield3.setValidationRule = { text in
            return text.count >= 4 ? nil : "invalid email"
        }
        textfield3.setBorderColor = UIColor.blue
        textfield3.setPlaceholderColor = UIColor.green
        textfield3.setAlertTextColor = UIColor.green
        
        stackView.addArrangedSubview(textfield1)
        stackView.addArrangedSubview(textfield2)
        stackView.addArrangedSubview(textfield3)
    }
    
    func addStackView() {
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.heightAnchor.constraint(equalToConstant: view.frame.height * 0.30),
            stackView.widthAnchor.constraint(equalToConstant: view.frame.width * 0.80)
        ])
    }

}

