//
//  ColorStrategy.swift
//  birthday-tracker-ios
//
//  Created by Alex on 18.05.2022.
//

import Foundation
import UIKit

protocol ColorStrategy{
    func fontColor() -> UIColor
    func backgroundColor() -> UIColor
    func buttonBackgroundColor() -> UIColor
    func buttonBorderColor() -> CGColor
    func messageBackgroundColor() -> UIColor
    func tapBarBackgroundColor() -> UIColor
    func cellColor() -> UIColor
    func invisibleBackground() -> UIColor
    func gradient() -> CAGradientLayer
}

class ColorStrategyLight: ColorStrategy{
    func gradient() -> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor(red: 0.39, green: 0.40, blue: 0.95, alpha: 1.00).cgColor, UIColor(red: 0.39, green: 0.40, blue: 0.95, alpha: 0).cgColor]
        return gradient
    }
    
    func invisibleBackground() -> UIColor {
        UIColor(red: 0, green: 0, blue: 0, alpha: 0)
    }
    
    
    func tapBarBackgroundColor() -> UIColor {
        UIColor(red: 0.718, green: 0.718, blue: 0.992, alpha: 1)
    }
    
    func messageBackgroundColor() -> UIColor {
        return .gray
    }
    
    func backgroundColor() -> UIColor {
        .white
    }
    
    func buttonBackgroundColor() -> UIColor {
        UIColor(red: 0.599, green: 0.607, blue: 0.992, alpha: 1)
    }
    
    func buttonBorderColor() -> CGColor {
        return CGColor(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    func fontColor() -> UIColor {
        return .black
    }
    
    
    func cellColor() -> UIColor {
        UIColor(red: 0.835, green: 0.792, blue: 0.929, alpha: 1)
    }
}

class ColorStrategyDark: ColorStrategy{
    func gradient() -> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor(red: 0.39, green: 0.40, blue: 0.95, alpha: 1.00).cgColor, UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 0).cgColor]
        return gradient
    }
    
    func invisibleBackground() -> UIColor {
        UIColor(red: 0.718, green: 0.718, blue: 0.992, alpha: 0)
    }
    
    
    func fontColor() -> UIColor {
        .white
    }
    
    func backgroundColor() -> UIColor {
        UIColor(red: 0.114, green: 0.114, blue: 0.114, alpha: 1)
    }
    
    func buttonBackgroundColor() -> UIColor {
        UIColor(red: 0.392, green: 0.404, blue: 0.949, alpha: 1)
    }
    
    func buttonBorderColor() -> CGColor {
        return CGColor(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    func messageBackgroundColor() -> UIColor {
        .gray
    }
    
    func tapBarBackgroundColor() -> UIColor {
        return UIColor(red: 0.153, green: 0.153, blue: 0.165, alpha: 1)
    }
    
    
    func cellColor() -> UIColor {
        UIColor(red: 0.153, green: 0.153, blue: 0.165, alpha: 1)
    }
}

class ColorSkin{
    static let `default` = ColorSkin()
    var strategy: ColorStrategy
    private init(){
        strategy = ColorStrategyDark()
    }
    func switchStrategy(){
        if strategy is ColorStrategyDark {
            ColorSkin.default.strategy = ColorStrategyLight()
        }
        else {
            ColorSkin.default.strategy = ColorStrategyDark()
        }
    }
}
//стили для кнопки
//как привязать цветовую схему к системной
