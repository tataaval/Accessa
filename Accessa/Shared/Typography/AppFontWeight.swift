//
//  AppFontWeight.swift
//  Accessa
//
//  Created by Tatarella on 04.01.26.
//

enum AppFontWeight {
    case regular
    case semibold
    case bold

    var fontName: String {
        switch self {
        case .regular:
            return "Roboto-Regular"
        case .semibold:
            return "Roboto-Semibold"
        case .bold:
            return "Roboto-Bold"
        }
    }
}
