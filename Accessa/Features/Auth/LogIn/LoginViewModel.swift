//
//  LoginViewModel.swift
//  Accessa
//
//  Created by Tatarella on 05.01.26.
//

import Foundation

//MARK: - protocols
protocol LoginViewModelType {
    var input: LoginViewModelInput { get }
    var output: LoginViewModelOutput? { get set }
}

protocol LoginViewModelInput {
    func login(id: String, password: String)
}

protocol LoginViewModelOutput: AnyObject {
    func loginDidSucceed()
    func loginDidFail(error: String)
    func onValidationError(errors: [LoginInputField: String])
    func setLoading(_ isLoading: Bool)
}

//MARK: - viewmodel
final class LoginViewModel: LoginViewModelType {

    //MARK: - properties
    var input: LoginViewModelInput { self }
    weak var output: LoginViewModelOutput?

    // MARK: - Services
    private let validationService: ValidationServiceProtocol
    private let authService: AuthServiceProtocol
    private let sessionService: SessionServiceProtocol

    // MARK: - Init
    init(
        validationService: ValidationServiceProtocol = ValidationService(),
        authService: AuthServiceProtocol = AuthService(),
        sessionService: SessionServiceProtocol = SessionService()
    ) {
        self.validationService = validationService
        self.authService = authService
        self.sessionService = sessionService
    }
}

extension LoginViewModel: LoginViewModelInput {
    func login(id: String, password: String) {
        var errors: [LoginInputField: String] = [:]

        if let error = validationService.validateIdNumber(id) {
            errors[.idNumber] = error.errorDescription
        }

        if let error = validationService.validatePassword(password) {
            errors[.password] = error.errorDescription
        }

        if !errors.isEmpty {
            output?.onValidationError(errors: errors)
            return
        }

        output?.setLoading(true)

        Task {
            do {
                let response: LoginResponseModel =
                try await authService.login(id: id, password: password)
                self.output?.setLoading(false)
                try sessionService.saveToken(response.token)
                output?.loginDidSucceed()
            } catch {
                self.output?.setLoading(false)
                self.output?.loginDidFail(error: error.localizedDescription)
            }
        }
    }

}


