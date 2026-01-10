//
//  String+HTML.swift
//  Accessa
//
//  Created by Tatarella on 10.01.26.
//

import Foundation
import SwiftUI

extension String {
    var htmlToAttributedString: AttributedString? {
        guard let data = data(using: .utf8) else { return nil }

        do {
            let nsAttributed = try NSAttributedString(
                data: data,
                options: [
                    .documentType: NSAttributedString.DocumentType.html,
                    .characterEncoding: String.Encoding.utf8.rawValue
                ],
                documentAttributes: nil
            )
            return AttributedString(nsAttributed).styledAsBody()
        } catch {
            return nil
        }
    }
}

extension AttributedString {
    func styledAsBody() -> AttributedString {
        var copy = self

        copy.font = .app(size: .base)
        copy.foregroundColor = .colorGray600
        
        return copy
    }
}
