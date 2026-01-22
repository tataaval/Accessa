//
//  MapCoordinator.swift
//  Accessa
//
//  Created by Tatarella on 22.01.26.
//


import SwiftUI
import UIKit

final class MapCoordinator: Coordinator, OfferRouting {

    var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let view = MapView(router: self)
        let vc = UIHostingController(rootView: view)
        navigationController.setViewControllers([vc], animated: false)
    }

    func openOffer(id: Int) {
        navigationController.pushViewController(
            UIHostingController(rootView: OfferDetailView(offerId: id)),
            animated: true
        )
    }
}