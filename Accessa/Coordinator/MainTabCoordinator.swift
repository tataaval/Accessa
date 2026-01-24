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
    private let container: AppContainer

    init(appCoordinator: AppCoordinator, container: AppContainer) {
        self.appCoordinator = appCoordinator
        self.container = container
    }

    func start() {
        tabBarController.viewControllers = [
            makeHome(),
            makeOffers(),
            makeMap(),
            makePartners(),
            makeProfile()
        ]
    }

    private func makeHome() -> UIViewController {
        let navigationContoller = UINavigationController()
        let coordinator = HomeCoordinator(navigationController: navigationContoller, container: container)
        childCoordinators.append(coordinator)
        coordinator.start()

        navigationContoller.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        return navigationContoller
    }

    private func makeOffers() -> UIViewController {
        let navigationContoller = UINavigationController()
        let coordinator = OffersCoordinator(navigationController: navigationContoller)
        childCoordinators.append(coordinator)
        coordinator.start()

        navigationContoller.tabBarItem = UITabBarItem(title: "Offers", image: UIImage(systemName: "gift"), tag: 1)
        return navigationContoller
    }

    private func makeMap() -> UIViewController {
        let navigationContoller = UINavigationController()
        let coordinator = MapCoordinator(navigationController: navigationContoller)
        childCoordinators.append(coordinator)
        coordinator.start()

        navigationContoller.tabBarItem = UITabBarItem(title: "Map", image: UIImage(systemName: "map"), tag: 2)
        return navigationContoller
    }

    private func makePartners() -> UIViewController {
        let navigationContoller = UINavigationController()
        let coordinator = PartnersCoordinator(navigationController: navigationContoller)
        childCoordinators.append(coordinator)
        coordinator.start()

        navigationContoller.tabBarItem = UITabBarItem(title: "Partners", image: UIImage(systemName: "building.2"), tag: 3)
        return navigationContoller
    }

    private func makeProfile() -> UIViewController {
        let navigationContoller = UINavigationController()
        let coordinator = ProfileContainerCoordinator(navigationController: navigationContoller, container: container)
        childCoordinators.append(coordinator)
        coordinator.start()

        navigationContoller.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 4)
        return navigationContoller
    }
}
