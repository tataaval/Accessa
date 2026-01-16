//
//  ProfileInputItemView.swift
//  Accessa
//
//  Created by Tatarella on 16.01.26.
//

import SwiftUI

struct ProfileInputItemView: View {
    //MARK: - properties
    let title: String
    let placeholder: String
    var error: String? = nil
    var isEditable: Bool = true
    var showSaveButton: Bool = false
    var onSave: (() -> Void)? = nil

    @Binding var value: String

    //MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {

            Text(title)
                .font(.app(size: .sm, weight: .semibold))
                .foregroundStyle(.colorGray900)

            HStack(spacing: 12) {

                if isEditable {
                    TextField(placeholder, text: $value)
                        .padding()
                        .background(.colorGray200)
                        .cornerRadius(14)
                } else {
                    Text(value.isEmpty ? placeholder : value)
                        .font(.app(size: .sm))
                        .foregroundStyle(.colorGray900)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(.colorGray200)
                        .cornerRadius(14)
                }

                if showSaveButton {
                    Button {
                        onSave?()
                    } label: {
                        Text("Update")
                            .font(.app(size: .sm, weight: .semibold))
                            .padding(.horizontal, 14)
                            .padding(.vertical, 10)
                            .background(Color.colorPrimary)
                            .foregroundStyle(.white)
                            .cornerRadius(12)
                    }
                }
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
