//
//  UIFont+Extensions.swift
//  Accessa
//
//  Created by Tatarella on 04.01.26.
//

import UIKit

extension UIFont {

    static func app(size: AppFontSize, weight: AppFontWeight = .regular) -> UIFont {
        UIFont(name: weight.fontName,size: size.rawValue) ?? .systemFont(ofSize: size.rawValue, weight: .regular)
    }
}
