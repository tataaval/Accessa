//
//  HomeCoordinator.swift
//  Accessa
//
//  Created by Tatarella on 03.01.26.
//


import UIKit
import SwiftUI

protocol HomeRouter {
    func openOffer(id: Int)
    func openOrganization(organizationPageId: Int, organizationItemId: Int)
}

final class HomeCoordinator: Coordinator, HomeRouter, OfferRouting {

    var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
       self.navigationController = navigationController
    }

    func start() {
       let view = HomeView(router: self)
       let vc = UIHostingController(rootView: view)
       navigationController.setViewControllers([vc], animated: false)
    }

    func openOffer(id: Int) {
        push(OfferDetailView(offerId: id))
    }

    func openOrganization(organizationPageId: Int, organizationItemId: Int) {
        push(PartnerDetailView(organizationPageId: organizationPageId, organizationItemId: organizationItemId, router: self))
    }

    private func push<V: View>(_ view: V) {
        navigationController.pushViewController(
            UIHostingController(rootView: view),
            animated: true
        )
    }
}
