//
//  HomeCoordinator.swift
//  Accessa
//
//  Created by Tatarella on 03.01.26.
//

import SwiftUI
import UIKit

protocol HomeRouter {
    func openOffer(id: Int)
    func openOrganization(organizationPageId: Int, organizationItemId: Int)
}

final class HomeCoordinator: Coordinator, HomeRouter, OfferRouting {

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
        let viewModel = container.dependencies.resolve(HomeViewModel.self)
        let view = HomeView(viewModel: viewModel, router: self)
        let vc = UIHostingController(rootView: view)
        navigationController.setViewControllers([vc], animated: false)
    }

    func openOffer(id: Int) {
        let viewModel = container.makeOfferDetailViewModel(id: id)
        let view = OfferDetailView(viewModel: viewModel)
        push(view)
    }

    func openOrganization(organizationPageId: Int, organizationItemId: Int) {
        let viewModel = container.makePartnerDetailViewModel(
            organizationPageId: organizationPageId,
            organizationItemId: organizationItemId
        )
        let view = PartnerDetailView(
            viewModel: viewModel,
            router: self
        )
        push(view)

    }

    private func push<V: View>(_ view: V) {
        navigationController.pushViewController(
            UIHostingController(rootView: view),
            animated: true
        )
    }
}
