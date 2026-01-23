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

    var onAuthSuccess: (() -> Void)?

    init(
        navigationController: UINavigationController,
        sessionService: SessionServiceProtocol
    ) {
        self.navigationController = navigationController
        self.sessionService = sessionService
    }

    func start() {
        showLogin()
    }

    private func showLogin() {
        let viewModel = LoginViewModel(sessionService: sessionService)

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
        let viewModel = RegisterViewModel()
        navigationController.pushViewController(RegisterViewController(viewModel: viewModel), animated: true)
    }

    private func showForgot() {
        let viewModel = ForgotPasswordViewModel()
        navigationController.pushViewController(ForgotPasswordViewController(viewModel: viewModel), animated: true)
    }
}

