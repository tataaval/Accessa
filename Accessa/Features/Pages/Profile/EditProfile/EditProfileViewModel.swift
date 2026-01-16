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
    private let networkService: NetworkServiceProtocol
    private let validationService: ValidationServiceProtocol

    // MARK: - Init
    init(
        networkService: NetworkServiceProtocol,
        validationService: ValidationServiceProtocol
    ) {
        self.networkService = networkService
        self.validationService = validationService
    }

    // MARK: - Load Functions
    func loadData() async {
        isLoading = true
        errorMessage = nil

        do {
            async let userInfoTask = fetchUserInfo()

            let result = try await userInfoTask
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

    private func fetchUserInfo() async throws -> UserProfileModel {
        let response: UserProfileModel =
            try await networkService.fetch(from: API.profileInfo)
        return response
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
            let _: UpdateMobileResponseModel =
                try await networkService.fetch(
                    from: API.updateMobile(mobile: mobile)
                )

            verificationCode = ""
            showMobileVerificationSheet = true

        } catch {
            validationError = error.localizedDescription
        }

    }

    private func updateMobile(mobile: String) async throws {
        let _: UpdateMobileResponseModel =
            try await networkService.fetch(
                from: API.updateMobile(mobile: mobile)
            )
    }

    //MARK: - Verify Code
    func verifyMobile() async {

        do {
            let _ =
                try await verify(
                    mobile: mobile,
                    verificationCode: verificationCode
                )
            originalMobile = mobile
            successMessage = "Mobile number was updated successfully. "
            showMobileVerificationSheet = false

        } catch {
            validationError = error.localizedDescription
        }

    }

    private func verify(mobile: String, verificationCode: String) async throws {
        let _: VerifyMobileResponseModel =
            try await networkService.fetch(
                from: API.verifyMobile(mobile: mobile, code: verificationCode)
            )
    }

}
