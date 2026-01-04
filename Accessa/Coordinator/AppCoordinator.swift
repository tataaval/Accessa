//
//  AppCoordinator.swift
//  Accessa
//
//  Created by Tatarella on 03.01.26.
//


import UIKit

final class AppCoordinator {

    private let window: UIWindow
    private var childCoordinators: [Coordinator] = []

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        showAuth()
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
}
