//
//  ChangePasswordView.swift
//  Accessa
//
//  Created by Tatarella on 03.01.26.
//

import SwiftUI

struct ChangePasswordView: View {
    //MARK: StateObject
    @StateObject private var viewModel: ChangePasswordViewModel

    @Environment(\.dismiss) private var dismiss

    //MARK: Init
    init() {
        _viewModel = StateObject(
            wrappedValue: ChangePasswordViewModel(
                networkService: NetworkService.shared,
                validationService: ValidationService()
            )
        )
    }

    //MARK: Body
    var body: some View {
        ScrollView {
            if viewModel.isSuccess {
                ChangePasswordSuccessView {
                    dismiss()
                }
            } else {
                formView
            }
        }
        .background(.colorGray200)
        .alert(
            "Error",
            isPresented: Binding(
                get: { viewModel.apiError != nil },
                set: { _ in viewModel.apiError = nil }
            )
        ) {
            Button("Retry") {
                Task { await viewModel.resetPassword() }
            }
            Button("OK", role: .cancel) {}
        } message: {
            Text(viewModel.apiError ?? "An unknown error occurred")
        }
    }

    //MARK: Helper View
    var formView: some View {
        VStack(alignment: .leading, spacing: 24) {
            FormHeader(title: "Change Password", subtitle: "Keep your account secure by updating your password regularly.")
            InputItemView(
                title: "Old Password",
                placeholder: "Enter old password",
                hint: "Must be at least 8 characters long",
                error: viewModel.errors[.oldPassword],
                value: $viewModel.oldPassword
            )
            InputItemView(
                title: "New Password",
                placeholder: "Enter new password",
                hint: "Must be at least 8 characters long",
                error: viewModel.errors[.newPassword],
                value: $viewModel.newPassword
            )
            InputItemView(
                title: "Confirm New Password",
                placeholder: "Confirm New Password",
                error: viewModel.errors[.confirmPassword],
                value: $viewModel.confirmPassword
            )
            AppButton(
                title: "Update Password",
                isLoading: viewModel.isLoading
            ) {
                Task {
                    await viewModel.resetPassword()
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
