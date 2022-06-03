//
//  ExtentionUIButton.swift
//  birthday-tracker-ios
//
//  Created by Alex on 22.05.2022.
//

import Foundation
import UIKit

extension UIButton{
    func settingsUI(backgroundColor: UIColor,
                    title: String,
                    titleColor: UIColor,
                    cornerRadius: CGFloat){
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.layer.cornerRadius = cornerRadius
        self.layer.shadowRadius = 4.0
        self.layer.shadowOpacity = 0.6
        self.layer.shadowOffset = CGSize.zero
    }
}

extension UILabel{
    func settingsUI(textAlignment: NSTextAlignment,
                    text: String,
                    backgroundColor: UIColor,
                    tintColor: UIColor,
                    masksToBounds: Bool,
                    cornerRadius: CGFloat){
        self.backgroundColor = backgroundColor
        self.textAlignment = textAlignment
        self.text = text
        self.tintColor = tintColor
        self.textColor = tintColor
        self.backgroundColor = backgroundColor
        self.layer.masksToBounds = masksToBounds
        self.layer.cornerRadius = cornerRadius
    }
}

extension UITextField{
    func settingUI(placeholder: String){
        self.layer.masksToBounds = true
        self.layer.borderColor = ColorSkin.default.strategy.buttonBorderColor()
        self.layer.borderWidth = 2
        self.layer.cornerRadius = 10
        self.placeholder = placeholder
        self.borderStyle = .roundedRect
    }
}
