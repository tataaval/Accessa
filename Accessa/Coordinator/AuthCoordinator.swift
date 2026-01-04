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
        let vc = LoginViewController()
        vc.onLoginSuccess = { [weak self] in
            self?.appCoordinator?.showMain()
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
        navigationController.pushViewController(RegisterViewController(), animated: true)
    }
    
    private func showForgot() {
        navigationController.pushViewController(ForgotPasswordViewController(), animated: true)
    }
}
