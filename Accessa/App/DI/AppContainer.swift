//
//  AppContainer.swift
//  Accessa
//
//  Created by Tatarella on 24.01.26.
//

final class AppContainer {

    let dependencies = DependencyContainer()

    private let sessionService: SessionServiceProtocol = SessionService()

    init() {
        registerServiceDependencies()
        registerViewModelDependencies()
    }

    // MARK: - Services
    private func registerServiceDependencies() {
        dependencies.register(SessionServiceProtocol.self) { [weak self] in
            guard let self else { fatalError("AppContainer is deallocated") }
            return self.sessionService
        }

        dependencies.register(ValidationServiceProtocol.self) {
            ValidationService()
        }

        dependencies.register(AuthServiceProtocol.self) {
            AuthService()
        }

        dependencies.register(ProfileServiceProtocol.self) {
            ProfileService()
        }
    }

    // MARK: - ViewModels
    private func registerViewModelDependencies() {

        // MARK: - Auth flow
        dependencies.register(LoginViewModel.self) {
            LoginViewModel(
                validationService: self.dependencies.resolve(
                    ValidationServiceProtocol.self
                ),
                authService: self.dependencies.resolve(AuthServiceProtocol.self),
                sessionService: self.dependencies.resolve(
                    SessionServiceProtocol.self
                )
            )
        }

        dependencies.register(RegisterViewModel.self) {
            RegisterViewModel(
                validationService: self.dependencies.resolve(
                    ValidationServiceProtocol.self
                ),
                authService: self.dependencies.resolve(AuthServiceProtocol.self)
            )
        }

        dependencies.register(ForgotPasswordViewModel.self) {
            ForgotPasswordViewModel(
                validationService: self.dependencies.resolve(
                    ValidationServiceProtocol.self
                ),
                authService: self.dependencies.resolve(AuthServiceProtocol.self)
            )
        }

        // MARK: - Profile
        dependencies.register(ProfileViewModel.self) {
            ProfileViewModel(
                profileService: self.dependencies.resolve(
                    ProfileServiceProtocol.self
                )
            )
        }

        dependencies.register(EditProfileViewModel.self) {
            EditProfileViewModel(
                profileService: self.dependencies.resolve(
                    ProfileServiceProtocol.self
                ),
                validationService: self.dependencies.resolve(
                    ValidationServiceProtocol.self
                )
            )
        }

        dependencies.register(ChangePasswordViewModel.self) {
            ChangePasswordViewModel(
                profileService: self.dependencies.resolve(
                    ProfileServiceProtocol.self
                ),
                validationService: self.dependencies.resolve(
                    ValidationServiceProtocol.self
                )
            )
        }
    }
}
