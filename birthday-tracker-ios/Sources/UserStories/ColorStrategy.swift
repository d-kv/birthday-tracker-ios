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
    func whishlistCellBackroundColor() -> UIColor
}

class ColorStrategyLight: ColorStrategy{
    
    func whishlistCellBackroundColor() -> UIColor {
        .lightGray
    }
    
    func tapBarBackgroundColor() -> UIColor {
        return .yellow
    }
    
    func messageBackgroundColor() -> UIColor {
        return .systemPink
    }
    
    func backgroundColor() -> UIColor {
        .white
    }
    
    func buttonBackgroundColor() -> UIColor {
        .yellow
    }
    
    func buttonBorderColor() -> CGColor {
        return CGColor(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    func fontColor() -> UIColor {
        return .black
    }
}

class ColorStrategyDark: ColorStrategy{
    
    func whishlistCellBackroundColor() -> UIColor {
        .lightGray
    }
    
    func fontColor() -> UIColor {
        .black
    }
    
    func backgroundColor() -> UIColor {
        UIColor(red: 0.114, green: 0.114, blue: 0.114, alpha: 1)
    }
    
    func buttonBackgroundColor() -> UIColor {
        UIColor(red: 1, green: 0.867, blue: 0.176, alpha: 1)
    }
    
    func buttonBorderColor() -> CGColor {
        return CGColor(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    func messageBackgroundColor() -> UIColor {
        .gray
    }
    
    func tapBarBackgroundColor() -> UIColor {
        UIColor(red: 1, green: 0.867, blue: 0.176, alpha: 1)
    }
    
    
}

class ColorSkin{
    static let `default` = ColorSkin()
    var strategy: ColorStrategy
    private init(){
        strategy = ColorStrategyLight()
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
