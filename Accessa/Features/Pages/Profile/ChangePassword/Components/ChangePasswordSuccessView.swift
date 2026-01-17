//
//  ChangePasswordSuccessView.swift
//  Accessa
//
//  Created by Tatarella on 15.01.26.
//

import SwiftUI

struct ChangePasswordSuccessView: View {
    //MARK: - properties
    let onDone: () -> Void

    //MARK: - Body
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 64))
                .foregroundStyle(.colorSecondary)
            Text("Password Updated")
                .font(.app(size: .lg, weight: .bold))
                .foregroundStyle(.colorGray900)
            Text("Your password has been changed successfully.")
                .font(.app(size: .sm, weight: .bold))
                .foregroundStyle(.colorGray500)
                .multilineTextAlignment(.center)
            Spacer()
            AppButton(title: "Go To Profile", isLoading: false) {
                onDone()
            }
        }
        .padding()
    }
}
