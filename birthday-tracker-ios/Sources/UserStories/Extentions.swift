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
                    cornerRadius: CGFloat,
                    borderWidth: CGFloat,
                    borderColor: CGColor){
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor
    }
}

extension UILabel{
    func settingsUI(textAlignment: NSTextAlignment,
                    text: String,
                    backgroundColor: UIColor,
                    tintColor: UIColor,
                    masksToBounds: Bool,
                    cornerRadius: CGFloat,
                    borderWidth: CGFloat,
                    borderColor: CGColor){
        self.backgroundColor = backgroundColor
        self.textAlignment = textAlignment
        self.text = text
        self.tintColor = tintColor
        self.textColor = tintColor
        self.backgroundColor = backgroundColor
        self.layer.masksToBounds = masksToBounds
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor
    }
}
