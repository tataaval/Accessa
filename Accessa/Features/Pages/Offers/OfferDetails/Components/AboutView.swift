//
//  AboutView.swift
//  Accessa
//
//  Created by Tatarella on 10.01.26.
//

import SwiftUI

struct AboutView: View {
    //MARK: - Properties
    let text: AttributedString?

    //MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("About This Offer")
                .font(.app(size: .lg, weight: .bold))
                .foregroundStyle(.colorGray900)
            if let text {
                Text(text)
            }
        }
        .padding()
    }
}
