//
//  InputItemView.swift
//  Accessa
//
//  Created by Tatarella on 15.01.26.
//

import SwiftUI

struct InputItemView: View {
    //MARK: - Properties
    let title: String
    let placeholder: String
    var hint: String? = nil
    var error: String? = nil
    var disabled: Bool = false
    @Binding var value: String

    //MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.app(size: .sm, weight: .semibold))
                .foregroundStyle(.colorGray900)

            TextField(placeholder, text: $value)
                .padding()
                .background(disabled ? .colorGray300 : .colorGray200)
                .cornerRadius(14)
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(
                            error != nil ? Color.colorError : .clear,
                            lineWidth: 1
                        )
                )
                .disabled(disabled)

            if let hint {
                Text(hint)
                    .font(.app(size: .sm))
                    .foregroundColor(.colorGray500)
            }
            if let error {
                Text(error)
                    .font(.app(size: .sm))
                    .foregroundColor(.colorError)
            }
        }
        .padding()
        .background(.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.03), radius: 6, x: 0, y: 2)
        .padding(.horizontal)
    }
}
