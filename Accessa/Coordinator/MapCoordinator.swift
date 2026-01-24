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

    private let offerDetailService: OfferDetailServiceProtocol

    init(
        navigationController: UINavigationController,
        offerDetailService: OfferDetailServiceProtocol = OfferDetailService()
    ) {
        self.navigationController = navigationController
        self.offerDetailService = offerDetailService
    }

    func start() {
        let viewModel = MapViewModel()
        let view = MapView(viewModel: viewModel, router: self)
        let vc = UIHostingController(rootView: view)
        navigationController.setViewControllers([vc], animated: false)
    }

    func openOffer(id: Int) {
        let viewModel = OfferDetailViewModel(
            offerId: id,
            offerDetailService: offerDetailService
        )
        let view = OfferDetailView(viewModel: viewModel)
        navigationController.pushViewController(
            UIHostingController(rootView: view),
            animated: true
        )
    }
}
