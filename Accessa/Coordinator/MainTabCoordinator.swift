//
//  MainTabCoordinator.swift
//  Accessa
//
//  Created by Tatarella on 03.01.26.
//

import UIKit

final class MainTabCoordinator: Coordinator {

    let tabBarController = UITabBarController()
    var childCoordinators: [Coordinator] = []
    private weak var appCoordinator: AppCoordinator?

    init(appCoordinator: AppCoordinator) {
        self.appCoordinator = appCoordinator
    }

    func start() {
        tabBarController.viewControllers = [
            makeHome(),
            makeOffers(),
            makeProfile(),
        ]
    }

    private func makeHome() -> UIViewController {
        let navigationContoller = UINavigationController()
        let coordinator = HomeCoordinator(navigationController: navigationContoller)
        childCoordinators.append(coordinator)
        coordinator.start()

        navigationContoller.tabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(systemName: "house"),
            tag: 0
        )
        return navigationContoller
    }

    private func makeOffers() -> UIViewController {
        let navigationContoller = UINavigationController()
        let coordinator = OffersCoordinator(navigationController: navigationContoller)
        childCoordinators.append(coordinator)
        coordinator.start()

        navigationContoller.tabBarItem = UITabBarItem(
            title: "Offers",
            image: UIImage(systemName: "gift"),
            tag: 1
        )
        return navigationContoller
    }

    private func makeProfile() -> UIViewController {
        let navigationContoller = UINavigationController()
        let coordinator = ProfileCoordinator(
            navigationController: navigationContoller,
            appCoordinator: appCoordinator
        )
        childCoordinators.append(coordinator)
        coordinator.start()

        navigationContoller.tabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(systemName: "person"),
            tag: 2
        )
        return navigationContoller
    }
}
