//
//  AppCoordinator.swift
//  Accessa
//
//  Created by Tatarella on 03.01.26.
//

import UIKit

final class AppCoordinator {

    private let window: UIWindow
    private let container: AppContainer
    private var childCoordinators: [Coordinator] = []

    init(window: UIWindow, container: AppContainer) {
        self.window = window
        self.container = container
    }

    func start() {
        showMain()
        window.makeKeyAndVisible()
    }

    func showMain() {
        let main = MainTabCoordinator(appCoordinator: self, container: container)
        childCoordinators = [main]
        main.start()
        window.rootViewController = main.tabBarController
    }
}
