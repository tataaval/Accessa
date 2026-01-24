//
//  ProfileContainerCoordinator.swift
//  Accessa
//
//  Created by Tatarella on 23.01.26.
//

import UIKit

final class ProfileContainerCoordinator: Coordinator {

    var childCoordinators: [Coordinator] = []

    private let navigationController: UINavigationController
    private let container: AppContainer
    
    private let sessionService: SessionServiceProtocol

    init(
        navigationController: UINavigationController,
        container: AppContainer
    ) {
        self.navigationController = navigationController
        self.container = container

        self.sessionService = container.dependencies.resolve(
            SessionServiceProtocol.self
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleUnauthorized),
            name: .unauthorized,
            object: nil
        )
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    func start() {
        showCorrectFlow()
    }

    private func showCorrectFlow() {
        childCoordinators.removeAll()

        if sessionService.token != nil {
            showProfileFlow()
        } else {
            showAuthFlow()
        }
    }

    private func showAuthFlow() {
        let auth = AuthCoordinator(
            navigationController: navigationController,
            container: container
        )

        auth.onAuthSuccess = { [weak self] in
            self?.showProfileFlow()
        }

        childCoordinators = [auth]
        auth.start()
    }

    private func showProfileFlow() {
        let profile = ProfileCoordinator(
            navigationController: navigationController,
            container: container

        )

        profile.onLogout = { [weak self] in
            self?.showAuthFlow()
        }

        childCoordinators = [profile]
        profile.start()
    }

    @objc private func handleUnauthorized() {
        try? sessionService.clearSession()
        showAuthFlow()
    }
}
