//
//  DrawFeatures.swift
//  birthday-tracker-ios
//
//  Created by Alex on 03.05.2022.
//

import Foundation
import UIKit

func addSubviewsTurnOnConstraints(view: UIView, elements: [UIView]){
    for element in elements {
        view.addSubview(element)
        element.translatesAutoresizingMaskIntoConstraints = false
    }
}


