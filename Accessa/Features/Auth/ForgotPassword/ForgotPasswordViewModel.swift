//
//  ForgotPasswordViewModel.swift
//  Accessa
//
//  Created by Tatarella on 06.01.26.
//

import Foundation

//MARK: - protocols
protocol ForgotPasswordViewModelType {
    var input: ForgotPasswordViewModelInput { get }
    var output: ForgotPasswordViewModelOutput? { get set }
}

protocol ForgotPasswordViewModelInput {
    func sendInstructions(email: String)
}

protocol ForgotPasswordViewModelOutput: AnyObject {
    func sendInstructionsDidComplete()
    func sendInstructionsDidFail(error: String)
    func onValidationError(errors: [ForgotPasswordInputField: String])
    func setLoading(_ isLoading: Bool)
}

//MARK: - viewmodel
final class ForgotPasswordViewModel: ForgotPasswordViewModelType {

    //MARK: - properties
    var input: ForgotPasswordViewModelInput { self }
    weak var output: ForgotPasswordViewModelOutput?

    // MARK: - Services
    private let validationService: ValidationServiceProtocol
    private let networkService: NetworkServiceProtocol

    // MARK: - Init
    init(
        validationService: ValidationServiceProtocol = ValidationService(),
        networkService: NetworkServiceProtocol = NetworkService.shared
    ) {
        self.validationService = validationService
        self.networkService = networkService
    }
}

extension ForgotPasswordViewModel: ForgotPasswordViewModelInput {
    func sendInstructions(email: String) {
        var errors: [ForgotPasswordInputField: String] = [:]

        if let error = validationService.validateEmail(email) {
            errors[.email] = error.errorDescription
        }

        if !errors.isEmpty {
            output?.onValidationError(errors: errors)
            return
        }

        output?.setLoading(true)

        Task {
            do {
                let _: ForgotPasswordResponseModel =
                    try await networkService.fetch(
                        from: API.forgotPassword(email: email)
                    )
                self.output?.setLoading(false)
                output?.sendInstructionsDidComplete()
            } catch {
                self.output?.setLoading(false)
                self.output?.sendInstructionsDidFail(
                    error: error.localizedDescription
                )
                print(error)
            }
        }

    }
}
