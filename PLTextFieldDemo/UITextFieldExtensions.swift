//
//  UITextFieldExtensions.swift
//  PLTextFieldDemo
//
//  Created by fahreddin on 21.07.2022.
//

import UIKit

extension UITextField {
    
    func addBottomBorder(with color: UIColor){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1)
        bottomLine.backgroundColor = color.cgColor
        borderStyle = .none
        layer.addSublayer(bottomLine)
    }
    
}
