//
//  EditProfileView.swift
//  Accessa
//
//  Created by Tatarella on 03.01.26.
//

import SwiftUI

struct EditProfileView: View {
    //MARK: StateObject
    @StateObject private var viewModel: EditProfileViewModel

    //MARK: Init
    init() {
        _viewModel = StateObject(
            wrappedValue: EditProfileViewModel(
                networkService: NetworkService.shared,
                validationService: ValidationService()
            )
        )
    }

    //MARK: Body
    var body: some View {
        ScrollView {
            if viewModel.isLoading {
                LoadingOverlay(text: "Profile Info Loading...")
            } else {
                formView
            }
        }
        .background(.colorGray200)
        .task {
            await viewModel.loadData()
        }
        .alert(
            "Error",
            isPresented: Binding(
                get: { viewModel.errorMessage != nil },
                set: { _ in viewModel.errorMessage = nil }
            )
        ) {
            Button("Retry") {
                Task { await viewModel.loadData() }
            }
            Button("OK", role: .cancel) {}
        } message: {
            Text(viewModel.errorMessage ?? "An unknown error occurred")
        }
        .alert(
            "Success",
            isPresented: Binding(
                get: { viewModel.successMessage != nil },
                set: { _ in viewModel.successMessage = nil }
            )
        ) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(viewModel.successMessage ?? "")
        }
        .sheet(isPresented: $viewModel.showMobileVerificationSheet) {
            verifyNumber
                .padding()
        }
    }

    //MARK: Helper Views
    var formView: some View {
        VStack(alignment: .leading, spacing: 24) {
            FormHeader(title: "Profile Info")
            ProfileInputItemView(
                title: "Full Name",
                placeholder: "Full Name",
                isEditable: false,
                showSaveButton: false,
                value: $viewModel.fullName
            )
            ProfileInputItemView(
                title: "ID Number",
                placeholder: "ID Number",
                isEditable: false,
                showSaveButton: false,
                value: $viewModel.idNumber
            )
            ProfileInputItemView(
                title: "Email",
                placeholder: "Email",
                isEditable: false,
                showSaveButton: false,
                value: $viewModel.email
            )
            ProfileInputItemView(
                title: "Mobile Number",
                placeholder: "Mobile Number",
                error: viewModel.validationError,
                showSaveButton: true,
                onSave: {
                    Task { await viewModel.updateMobileNumber() }
                },
                value: $viewModel.mobile
            )
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    var verifyNumber: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Verify Mobile")
                    .font(.app(size: .lg, weight: .semibold))
                    .foregroundStyle(.colorGray900)
            }

            Text("Enter the verification code we sent to your number.")
                .font(.app(size: .sm))
                .foregroundStyle(.colorGray600)

            TextField(
                "Verification code",
                text: $viewModel.verificationCode
            )
            .keyboardType(.numberPad)
            .padding()
            .background(.colorGray200)
            .cornerRadius(14)

            HStack(spacing: 12) {
                Button {
                    viewModel.showMobileVerificationSheet = false
                } label: {
                    Text("Cancel")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.colorGray200)
                        .foregroundStyle(.colorGray900)
                        .cornerRadius(14)
                }

                Button {
                    Task { await viewModel.verifyMobile() }
                } label: {
                    Text("Confirm")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.colorPrimary)
                        .foregroundStyle(.white)
                        .cornerRadius(14)
                }
                .disabled(viewModel.verificationCode.isEmpty)
                .opacity(viewModel.verificationCode.isEmpty ? 0.5 : 1)
            }
        }
    }
}
