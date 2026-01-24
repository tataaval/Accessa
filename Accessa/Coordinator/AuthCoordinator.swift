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
    private let container: AppContainer

    var onAuthSuccess: (() -> Void)?

    init(
        navigationController: UINavigationController,
        container: AppContainer
    ) {
        self.navigationController = navigationController
        self.container = container
    }

    func start() {
        showLogin()
    }

    private func showLogin() {
        let viewModel = container.container.resolve(LoginViewModel.self)

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
        let viewModel = container.container.resolve(RegisterViewModel.self)
        navigationController.pushViewController(
            RegisterViewController(viewModel: viewModel),
            animated: true
        )
    }

    private func showForgot() {
        let viewModel = container.container.resolve(ForgotPasswordViewModel.self)
        navigationController.pushViewController(
            ForgotPasswordViewController(viewModel: viewModel),
            animated: true
        )
    }
}
