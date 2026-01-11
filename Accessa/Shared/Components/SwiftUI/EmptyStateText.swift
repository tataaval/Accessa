//
//  EmptyStateText.swift
//  Accessa
//
//  Created by Tatarella on 11.01.26.
//

import SwiftUI

struct EmptyStateText: View {
    //MARK: - Properties
    let text: String

    //MARK: - Body
    var body: some View {
        Text(text)
            .font(.app(size: .lg, weight: .semibold))
            .foregroundStyle(.colorPrimary)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .multilineTextAlignment(.center)
    }
}
