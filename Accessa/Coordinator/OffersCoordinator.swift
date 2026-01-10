//
//  OffersCoordinator.swift
//  Accessa
//
//  Created by Tatarella on 03.01.26.
//

import SwiftUI
import UIKit

protocol OffersRouter {
    func openOffer(id: Int)
}

final class OffersCoordinator: Coordinator, OffersRouter {
    var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let view = OffersListView(router: self)
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
