//
//  ChangePasswordViewModel.swift
//  Accessa
//
//  Created by Tatarella on 15.01.26.
//

import Combine
import Foundation

final class ChangePasswordViewModel: ObservableObject {

    enum InputField {
        case oldPassword
        case newPassword
        case confirmPassword
    }

    // MARK: - Published Properties
    @Published var oldPassword = ""
    @Published var newPassword = ""
    @Published var confirmPassword = ""

    @Published var errors: [InputField: String] = [:]
    @Published var isLoading = false
    @Published var isSuccess = false
    @Published var apiError: String?

    // MARK: - Private Properties
    private let profileService: ProfileServiceProtocol
    private let validationService: ValidationServiceProtocol

    // MARK: - Init
    init(
        profileService: ProfileServiceProtocol,
        validationService: ValidationServiceProtocol
    ) {
        self.profileService = profileService
        self.validationService = validationService
    }

    func resetPassword() async {
        errors.removeAll()
        apiError = nil

        if let error = validationService.validateEmptyValue(oldPassword) {
            errors[.oldPassword] = error.errorDescription
        }

        if let error = validationService.validatePassword(newPassword) {
            errors[.newPassword] = error.errorDescription
        }

        if let error = validationService.validateRepeatPassword(
            confirmPassword,
            password: newPassword
        ) {
            errors[.confirmPassword] = error.errorDescription
        }

        guard errors.isEmpty else { return }

        isLoading = true
        apiError = nil

        do {
            try await resetPass()
            isSuccess = true
        } catch {
            apiError = error.localizedDescription
        }
        isLoading = false
    }

    private func resetPass() async throws {
        try await profileService.changePassword(
            current: oldPassword,
            new: newPassword,
            confirm: confirmPassword
        )
    }
}
