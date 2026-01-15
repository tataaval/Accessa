//
//  ChangePasswordSuccessView.swift
//  Accessa
//
//  Created by Tatarella on 15.01.26.
//

import SwiftUI

struct ChangePasswordSuccessView: View {
    let onDone: () -> Void

    var body: some View {
        VStack(spacing: 24) {
            Spacer()

            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 64))
                .foregroundColor(.colorSecondary)

            Text("Password Updated")
                .font(.app(size: .lg, weight: .bold))
                .foregroundColor(.colorGray900)

            Text("Your password has been changed successfully.")
                .font(.app(size: .sm, weight: .bold))
                .foregroundColor(.colorGray500)
                .multilineTextAlignment(.center)

            Spacer()

            AppButton(title: "Go To Profile", isLoading: false) {
                onDone()
            }
        }
        .padding()
    }
}
