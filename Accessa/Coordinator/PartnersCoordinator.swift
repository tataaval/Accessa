//
//  PartnersCoordinator.swift
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
    private let container: AppContainer

    init(
        navigationController: UINavigationController,
        container: AppContainer
    ) {
        self.navigationController = navigationController
        self.container = container
    }

    func start() {
        let viewModel = container.dependencies.resolve(PartnerListViewModel.self)
        let view = PartnerListView(viewModel: viewModel, router: self)
        let vc = UIHostingController(rootView: view)
        navigationController.setViewControllers([vc], animated: false)
    }

    func openOrganization(organizationPageId: Int, organizationItemId: Int) {
        let viewModel = container.makePartnerDetailViewModel(organizationPageId: organizationPageId, organizationItemId: organizationItemId)
        let view = PartnerDetailView(
            viewModel: viewModel,
            router: self
        )

        navigationController.pushViewController(
            UIHostingController(rootView: view),
            animated: true
        )
    }

    func openOffer(id: Int) {
        let viewModel = container.makeOfferDetailViewModel(id: id)
        let view = OfferDetailView(viewModel: viewModel)

        navigationController.pushViewController(
            UIHostingController(rootView: view),
            animated: true
        )
    }
}
