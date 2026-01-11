//
//  SearchField.swift
//  Accessa
//
//  Created by Tatarella on 09.01.26.
//

import SwiftUI

struct SearchField: View {
    //MARK: - Properties
    @Binding var text: String
    let placeholder: String

    //MARK: - Body
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.colorGray500)

            TextField(placeholder, text: $text)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .font(.app(size: .base))

            if !text.isEmpty {
                Button {
                    text = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.colorGray900)
                }
            }
        }
        .padding()
        .background(.colorGray300.opacity(0.5))
        .cornerRadius(16)
    }
}
