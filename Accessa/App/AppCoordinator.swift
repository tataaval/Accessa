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
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    func start() {
        showMain()
        window.makeKeyAndVisible()
    }

    func showMain() {
        let main = MainTabCoordinator(appCoordinator: self, sessionService: sessionService)
        childCoordinators = [main]
        main.start()
        window.rootViewController = main.tabBarController
    }
}
