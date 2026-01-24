//
//  AuthCoordinator.swift
//  Accessa
//
//  Created by Tatarella on 03.01.26.
//

import UIKit

final class AuthCoordinator: Coordinator {

    var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    private let sessionService: SessionServiceProtocol
    private let validationService: ValidationServiceProtocol
    private let authService: AuthServiceProtocol

    var onAuthSuccess: (() -> Void)?

    init(
        navigationController: UINavigationController,
        sessionService: SessionServiceProtocol,
        validationService: ValidationServiceProtocol = ValidationService(),
        authService: AuthServiceProtocol = AuthService()
    ) {
        self.navigationController = navigationController
        self.sessionService = sessionService
        self.validationService = validationService
        self.authService = authService
    }

    func start() {
        showLogin()
    }

    private func showLogin() {
        let viewModel = LoginViewModel(
            validationService: validationService,
            authService: authService,
            sessionService: sessionService
        )

        let vc = LoginViewController(viewModel: viewModel)
        vc.onLoginSuccess = { [weak self] in
            self?.onAuthSuccess?()
        }

        vc.onRegister = { [weak self] in
            self?.showRegister()
        }

        vc.onForgot = { [weak self] in
            self?.showForgot()
        }

        navigationController.setViewControllers([vc], animated: false)
    }

    private func showRegister() {
        let viewModel = RegisterViewModel(
            validationService: validationService,
            authService: authService
        )
        navigationController.pushViewController(
            RegisterViewController(viewModel: viewModel),
            animated: true
        )
    }

    private func showForgot() {
        let viewModel = ForgotPasswordViewModel(
            validationService: validationService,
            authService: authService
        )
        navigationController.pushViewController(
            ForgotPasswordViewController(viewModel: viewModel),
            animated: true
        )
    }
}
