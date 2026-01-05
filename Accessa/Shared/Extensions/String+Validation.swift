//
//  String+Validation.swift
//  Accessa
//
//  Created by Tatarella on 05.01.26.
//

import Foundation

extension String {
    var isEmptyOrWhitespace: Bool {
        trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    func hasMinimumLength(_ length: Int) -> Bool {
        count >= length
    }

    var isValidEmail: Bool {
        let regex =
        #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: self)
    }
}
