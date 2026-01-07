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
    func register(name: String, IdNumber: String, phone: String, birthDate: String, email: String, password: String, repeatPassword: String)
}

protocol RegisterViewModelOutput: AnyObject {
    func registerDidSucceed()
    func registerDidFail(error: String)
    func onValidationError(errors: [String: String])
    func setLoading(_ isLoading: Bool)
}

//MARK: - viewmodel
final class RegisterViewModel: RegisterViewModelType {

    //MARK: - properties
    var input: RegisterViewModelInput { self }
    weak var output: RegisterViewModelOutput?

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
    // MARK: - Validation Helper
    private func validateInputs(name: String, IdNumber: String, phone: String, birthDate: String, email: String, password: String, repeatPassword: String) -> [String: String] {
        var errors: [String: String] = [:]
        
        if let error = validationService.validateEmptyValue(name) {
            errors["name"] = error.errorDescription
        }
        
        if let error = validationService.validateIdNumber(IdNumber) {
            errors["idNumber"] = error.errorDescription
        }
        
        if let error = validationService.validatePhoneNumber(phone) {
            errors["phone"] = error.errorDescription
        }
        
        if let error = validationService.validateEmptyValue(birthDate) {
            errors["birthDate"] = error.errorDescription
        }
        
        if let error = validationService.validateEmail(email) {
            errors["email"] = error.errorDescription
        }

        if let error = validationService.validatePassword(password) {
            errors["password"] = error.errorDescription
        }
        
        if let error = validationService.validateRepeatPassword(repeatPassword, password: password) {
            errors["repeatPassword"] = error.errorDescription
        }
        
        return errors
    }
}

extension RegisterViewModel: RegisterViewModelInput {
    func register(name: String, IdNumber: String, phone: String, birthDate: String, email: String, password: String, repeatPassword: String) {
        let errorMessages = validateInputs(name: name, IdNumber: IdNumber, phone: phone, birthDate: birthDate, email: email, password: password, repeatPassword: repeatPassword)
        
        if !errorMessages.isEmpty {
            output?.onValidationError(errors: errorMessages)
            return
        }
        
        output?.setLoading(true)
        
        Task {
            do {
                let _: RegisterResponseModel = try await networkService.fetch(from: API.register(name: name, IdNumber: IdNumber, phone: phone, birthDate: birthDate, email: email, password: password, repeatPassword: repeatPassword))
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
