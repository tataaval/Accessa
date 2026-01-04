//
//  Font+Extensions.swift
//  Accessa
//
//  Created by Tatarella on 04.01.26.
//

import SwiftUI

extension Font {

    static func app(size: AppFontSize, weight: AppFontWeight = .regular) -> Font {
        .custom(
            weight.fontName,
            size: size.rawValue
        )
    }
}
