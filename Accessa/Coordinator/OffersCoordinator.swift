//
//  OffersCoordinator.swift
//  Accessa
//
//  Created by Tatarella on 03.01.26.
//

import SwiftUI
import UIKit

protocol OfferRouting {
    func openOffer(id: Int)
}

final class OffersCoordinator: Coordinator, OfferRouting {
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
        let viewModel = container.dependencies.resolve(OffersListViewModel.self)
        let view = OffersListView(viewModel: viewModel, router: self)
        let vc = UIHostingController(rootView: view)
        navigationController.setViewControllers([vc], animated: false)
    }

    func openOffer(id: Int) {
        let viewModel = container.makeOfferDetailViewModel(id: id)
        let detailView = OfferDetailView(viewModel: viewModel)
        let vc = UIHostingController(rootView: detailView)
        navigationController.pushViewController(vc, animated: true)
    }

}
