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
        registerServiceDependencies()
        registerViewModelDependencies()
    }

    // MARK: - Services
    private func registerServiceDependencies() {
        container.register(SessionServiceProtocol.self) { [weak self] in
            guard let self else { fatalError("AppContainer is deallocated") }
            return self.sessionService
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

    // MARK: - ViewModels
    private func registerViewModelDependencies() {

        // MARK: - Auth flow
        container.register(LoginViewModel.self) {
            LoginViewModel(
                validationService: self.container.resolve(
                    ValidationServiceProtocol.self
                ),
                authService: self.container.resolve(AuthServiceProtocol.self),
                sessionService: self.container.resolve(
                    SessionServiceProtocol.self
                )
            )
        }

        container.register(RegisterViewModel.self) {
            RegisterViewModel(
                validationService: self.container.resolve(
                    ValidationServiceProtocol.self
                ),
                authService: self.container.resolve(AuthServiceProtocol.self)
            )
        }

        container.register(ForgotPasswordViewModel.self) {
            ForgotPasswordViewModel(
                validationService: self.container.resolve(
                    ValidationServiceProtocol.self
                ),
                authService: self.container.resolve(AuthServiceProtocol.self)
            )
        }

        // MARK: - Profile

        container.register(ProfileViewModel.self) {
            ProfileViewModel(
                profileService: self.container.resolve(
                    ProfileServiceProtocol.self
                )
            )
        }

        container.register(EditProfileViewModel.self) {
            EditProfileViewModel(
                profileService: self.container.resolve(
                    ProfileServiceProtocol.self
                ),
                validationService: self.container.resolve(
                    ValidationServiceProtocol.self
                )
            )
        }

        container.register(ChangePasswordViewModel.self) {
            ChangePasswordViewModel(
                profileService: self.container.resolve(
                    ProfileServiceProtocol.self
                ),
                validationService: self.container.resolve(
                    ValidationServiceProtocol.self
                )
            )
        }
    }
}
