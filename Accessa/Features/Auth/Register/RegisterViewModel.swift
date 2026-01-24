//
//  RegisterViewModel.swift
//  Accessa
//
//  Created by Tatarella on 06.01.26.
//

import Foundation

//MARK: - protocols
protocol RegisterViewModelType {
    var input: RegisterViewModelInput { get }
    var output: RegisterViewModelOutput? { get set }
}

protocol RegisterViewModelInput {
    func register(formData: RegisterRequestModel)
}

protocol RegisterViewModelOutput: AnyObject {
    func registerDidSucceed()
    func registerDidFail(error: String)
    func onValidationError(errors: [RegistrationInputField: String])
    func setLoading(_ isLoading: Bool)
}

//MARK: - viewmodel
final class RegisterViewModel: RegisterViewModelType {

    //MARK: - properties
    var input: RegisterViewModelInput { self }
    weak var output: RegisterViewModelOutput?

    // MARK: - Services
    private let validationService: ValidationServiceProtocol
    private let authService: AuthServiceProtocol

    // MARK: - Init
    init(
        validationService: ValidationServiceProtocol,
        authService: AuthServiceProtocol
    ) {
        self.validationService = validationService
        self.authService = authService
    }
    // MARK: - Validation Helper
    private func validateInputs(inputs: RegisterRequestModel)
        -> [RegistrationInputField: String]
    {

        var errors: [RegistrationInputField: String] = [:]

        if let error = validationService.validateEmptyValue(inputs.name) {
            errors[.name] = error.errorDescription
        }

        if let error = validationService.validateIdNumber(inputs.idNumber) {
            errors[.idNumber] = error.errorDescription
        }

        if let error = validationService.validatePhoneNumber(inputs.phone) {
            errors[.phone] = error.errorDescription
        }

        if let error = validationService.validateEmptyValue(inputs.birthDate) {
            errors[.birthDate] = error.errorDescription
        }

        if let error = validationService.validateEmail(inputs.email) {
            errors[.email] = error.errorDescription
        }

        if let error = validationService.validatePassword(inputs.password) {
            errors[.password] = error.errorDescription
        }

        if let error = validationService.validateRepeatPassword(
            inputs.repeatPassword,
            password: inputs.password
        ) {
            errors[.repeatPassword] = error.errorDescription
        }

        return errors
    }
}

extension RegisterViewModel: RegisterViewModelInput {
    func register(formData: RegisterRequestModel) {
        let errorMessages = validateInputs(inputs: formData)

        if !errorMessages.isEmpty {
            output?.onValidationError(errors: errorMessages)
            return
        }

        output?.setLoading(true)

        Task {
            do {
                try await authService.register(data: formData)
                self.output?.setLoading(false)
                output?.registerDidSucceed()
            } catch {
                self.output?.setLoading(false)
                self.output?.registerDidFail(error: error.localizedDescription)
                print(error)
            }
        }

    }
}
