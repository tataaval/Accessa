//
//  AuthCoordinator.swift
//  Accessa
//
//  Created by Tatarella on 03.01.26.
//


import UIKit

final class AuthCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    let navigationController = UINavigationController()
    private weak var appCoordinator: AppCoordinator?
    
    init(appCoordinator: AppCoordinator) {
        self.appCoordinator = appCoordinator
    }
    
    func start() {
        showLogin()
    }
    
    private func showLogin() {
        let viewModel = LoginViewModel()
        let viewContoller = LoginViewController(viewModel: viewModel)
        viewContoller.onLoginSuccess = { [weak self] in
            self?.appCoordinator?.showMain()
        }
        viewContoller.onRegister = { [weak self] in
            self?.showRegister()
        }
        viewContoller.onForgot = { [weak self] in
            self?.showForgot()
        }
        
        navigationController.setViewControllers([viewContoller], animated: false)
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
