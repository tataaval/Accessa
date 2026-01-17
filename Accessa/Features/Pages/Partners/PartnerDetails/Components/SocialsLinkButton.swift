//
//  SocialsLinkButton.swift
//  Accessa
//
//  Created by Tatarella on 13.01.26.
//

import SwiftUI

struct SocialsLinkButton: View {
    //MARK: - Properties
    let icon: String
    let title: String
    let url: String

    //MARK: - Body
    var body: some View {
        if let url = URL(string: url) {
            Link(destination: url) {
                content
            }
        } else {
            content
                .opacity(0.4)
        }
    }
}

private extension SocialsLinkButton {
    var content: some View {
        VStack(spacing: 8) {
            Image(icon)
                .renderingMode(.template)
                .foregroundStyle(.colorPrimary)

            Text(title)
                .font(.app(size: .sm, weight: .bold))
                .foregroundStyle(.colorPrimary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .colorGray900.opacity(0.05), radius: 3, y: 2)
    }
}
