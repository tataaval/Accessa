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
    private let sessionService: SessionServiceProtocol

    init(
        navigationController: UINavigationController,
        sessionService: SessionServiceProtocol
    ) {
        self.navigationController = navigationController
        self.sessionService = sessionService

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleUnauthorized),
            name: .unauthorized,
            object: nil
        )
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
            sessionService: sessionService
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
            sessionService: sessionService
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
