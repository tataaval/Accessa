//
//  PartnersRouter.swift
//  Accessa
//
//  Created by Tatarella on 13.01.26.
//

import SwiftUI
import UIKit

protocol PartnersRouter {
    func openOrganization(organizationPageId: Int, organizationItemId: Int)
    func openOffer(id: Int)
}

final class PartnersCoordinator: Coordinator, PartnersRouter, OfferRouting {
    var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let view = PartnerListView(router: self)
        let vc = UIHostingController(rootView: view)
        navigationController.setViewControllers([vc], animated: false)
    }

    func openOrganization(organizationPageId: Int, organizationItemId: Int) {
        navigationController.pushViewController(
            UIHostingController(rootView: PartnerDetailView(organizationPageId: organizationPageId, organizationItemId: organizationItemId, router: self)),
            animated: true
        )
    }
    
    func openOffer(id: Int) {
        navigationController.pushViewController(
            UIHostingController(rootView: OfferDetailView(offerId: id)),
            animated: true
        )
    }
}
