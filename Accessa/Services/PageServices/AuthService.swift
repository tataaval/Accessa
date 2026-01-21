//
//  AuthService.swift
//  Accessa
//
//  Created by Tatarella on 21.01.26.
//

protocol AuthServiceProtocol {
    func register(data: RegisterRequestModel) async throws
    func login(id: String, password: String) async throws -> LoginResponseModel
    func forgotPassword(email: String) async throws
}

final class AuthService: AuthServiceProtocol {
    private let network: NetworkServiceProtocol

    init(network: NetworkServiceProtocol = NetworkService.shared) {
        self.network = network
    }

    func register(data: RegisterRequestModel) async throws {
        let _: RegisterResponseModel = try await network.fetch(
            from: AuthAPI.register(
                name: data.name,
                idNumber: data.idNumber,
                phone: data.phone,
                birthDate: data.birthDate,
                email: data.email,
                password: data.password,
                repeatPassword: data.repeatPassword
            )
        )
    }

    func login(id: String, password: String) async throws -> LoginResponseModel {
        try await network.fetch(from: AuthAPI.login(idNumber: id, password: password))
    }

    func forgotPassword(email: String) async throws {
        let _: ForgotPasswordResponseModel = try await network.fetch(from: AuthAPI.forgotPassword(email: email))
    }
}
