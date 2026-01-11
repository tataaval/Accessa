//
//  FoundResultsText.swift
//  Accessa
//
//  Created by Tatarella on 11.01.26.
//

import SwiftUI

struct FoundResultsText: View {
    //MARK: - Properties
    let text: String

    //MARK: - Body
    var body: some View {
        HStack {
            Text(text)
                .font(.app(size: .sm, weight: .semibold))
                .foregroundStyle(.colorPrimary)
            Spacer()
        }
        .padding()
    }
}
