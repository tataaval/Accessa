//
//  ActionButton.swift
//  Accessa
//
//  Created by Tatarella on 14.01.26.
//

import SwiftUI

struct ActionButton: View {
    //MARK: - Properties
    let title: String
    let icon: String
    let onTap: () -> Void

    //MARK: - Body
    var body: some View {
        Button(action: onTap) {
            HStack {
                Image(systemName: icon)
                Text(title)
                    .font(.app(size: .base, weight: .semibold))
            }
            .foregroundStyle(.colorError)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(.colorError.opacity(0.08))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .padding(.horizontal)
        }
    }
}
