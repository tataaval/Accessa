//
//  EditProfileViewModel.swift
//  Accessa
//
//  Created by Tatarella on 16.01.26.
//

import Combine
import Foundation

final class EditProfileViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var email: String = ""
    @Published var mobile: String = ""
    @Published var idNumber: String = ""
    @Published var fullName: String = ""

    @Published var isLoading = false
    @Published var errorMessage: String?

    @Published var successMessage: String? = nil

    @Published var showMobileVerificationSheet = false
    @Published var verificationCode: String = ""
    @Published var originalMobile: String = ""

    @Published var validationError: String = ""

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

    // MARK: - Load Functions
    func loadData() async {
        isLoading = true
        errorMessage = nil

        do {
            let result = try await profileService.fetchUserInfo()

            self.email = result.email
            self.mobile = result.mobile
            self.originalMobile = result.mobile
            self.idNumber = result.idNumber
            self.fullName = result.fullName ?? "No Name"

        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }

    //MARK: - Update Mobile
    func updateMobileNumber() async {
        guard mobile != originalMobile else { return }

        validationError = ""

        if let error = validationService.validatePhoneNumber(mobile) {
            validationError = error.localizedDescription
            return
        }
        errorMessage = nil

        do {
            try await profileService.updateMobile(mobile: mobile)

            verificationCode = ""
            showMobileVerificationSheet = true

        } catch {
            validationError = error.localizedDescription
        }

    }

    //MARK: - Verify Code
    func verifyMobile() async {

        do {
            try await profileService.verifyMobile(
                mobile: mobile,
                code: verificationCode
            )

            originalMobile = mobile
            successMessage = "Mobile number was updated successfully. "
            showMobileVerificationSheet = false

        } catch {
            validationError = error.localizedDescription
        }

    }
}
