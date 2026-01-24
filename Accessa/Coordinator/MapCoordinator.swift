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
    private let container: AppContainer

    init(
        navigationController: UINavigationController,
        container: AppContainer
    ) {
        self.navigationController = navigationController
        self.container = container
    }

    func start() {
        let viewModel = container.dependencies.resolve(MapViewModel.self)
        let view = MapView(viewModel: viewModel, router: self)
        let vc = UIHostingController(rootView: view)
        navigationController.setViewControllers([vc], animated: false)
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
