//
//  AppContainer.swift
//  Accessa
//
//  Created by Tatarella on 24.01.26.
//

final class AppContainer {

    let container = DependencyContainer()

    private let sessionService: SessionServiceProtocol = SessionService()

    init() {
        registerDependencies()
    }

    private func registerDependencies() {
        // MARK: - Services
        
        container.register(SessionServiceProtocol.self) { [unowned self] in
            sessionService
        }

        container.register(ValidationServiceProtocol.self) {
            ValidationService()
        }

        container.register(AuthServiceProtocol.self) {
            AuthService()
        }
        
        container.register(ProfileServiceProtocol.self) {
            ProfileService()
        }
    }
}
