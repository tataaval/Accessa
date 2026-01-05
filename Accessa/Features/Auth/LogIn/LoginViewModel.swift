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

@MainActor
protocol LoginViewModelOutput: AnyObject {
    func loginDidSucceed()
    func loginDidFail(error: String)
    func onValidationError(errors: [String: String])
    func setLoading(_ isLoading: Bool)
}

//MARK: - viewmodel
final class LoginViewModel: LoginViewModelType {

    //MARK: - properties
    var input: LoginViewModelInput { self }
    weak var output: LoginViewModelOutput?

    // MARK: - Services
    private let validationService: ValidationServiceProtocol
    private let networkService: NetworkServiceProtocol
    private let sessionService: SessionServiceProtocol

    // MARK: - Init
    init(validationService: ValidationServiceProtocol = ValidationService(),
         networkService: NetworkServiceProtocol = NetworkService.shared,
         sessionService: SessionServiceProtocol = SessionService()) {
        self.validationService = validationService
        self.networkService = networkService
        self.sessionService = sessionService
    }
}

extension LoginViewModel: LoginViewModelInput {

    func login(id: String, password: String) {
        var errors: [String: String] = [:]

        if let e = validationService.validateIdNumber(id) {
            errors["idNumber"] = e.errorDescription
        }

        if let e = validationService.validatePassword(password) {
            errors["password"] = e.errorDescription
        }

        if !errors.isEmpty {
            output?.onValidationError(errors: errors)
            return
        }
        output?.setLoading(true)
        
        Task {
            do {
                let response: LoginResponseModel = try await networkService.fetch(from: API.login(IdNumber: id, password: password))
                self.output?.setLoading(false)
                try sessionService.saveToken(response.token)
                output?.loginDidSucceed()
            } catch {
                self.output?.setLoading(false)
                self.output?.loginDidFail(error: error.localizedDescription)
                print(error.localizedDescription)
            }
        }
        
    }
}
