//
//  AppCoordinator.swift
//  Accessa
//
//  Created by Tatarella on 03.01.26.
//

import UIKit

final class AppCoordinator {

    private let window: UIWindow
    private let sessionService: SessionServiceProtocol
    private var childCoordinators: [Coordinator] = []

    init(
        window: UIWindow,
        sessionService: SessionServiceProtocol = SessionService()
    ) {
        self.window = window
        self.sessionService = sessionService
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
        if sessionService.token != nil {
            showMain()
        } else {
            showAuth()
        }
        window.makeKeyAndVisible()
    }

    func showAuth() {
        let auth = AuthCoordinator(appCoordinator: self)
        childCoordinators = [auth]
        auth.start()
        window.rootViewController = auth.navigationController
    }

    func showMain() {
        let main = MainTabCoordinator(appCoordinator: self)
        childCoordinators = [main]
        main.start()
        window.rootViewController = main.tabBarController
    }

    func logout() {
        try? sessionService.clearSession()
        showAuth()
    }

    @objc private func handleUnauthorized() {
        logout()
    }
}
