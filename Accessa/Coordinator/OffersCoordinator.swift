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
    private let offersService: OffersServiceProtocol
    private let offerDetailService: OfferDetailServiceProtocol

    init(
        navigationController: UINavigationController,
        offersService: OffersServiceProtocol = OffersService(),
        offerDetailService: OfferDetailServiceProtocol = OfferDetailService()
    ) {
        self.navigationController = navigationController
        self.offersService = offersService
        self.offerDetailService = offerDetailService
    }

    func start() {
        let viewModel = OffersListViewModel(offersService: offersService)
        let view = OffersListView(viewModel: viewModel, router: self)
        let vc = UIHostingController(rootView: view)
        navigationController.setViewControllers([vc], animated: false)
    }

    func openOffer(id: Int) {
        let detailViewModel = OfferDetailViewModel(
            offerId: id,
            offerDetailService: offerDetailService
        )
        let detailView = OfferDetailView(viewModel: detailViewModel)
        let vc = UIHostingController(rootView: detailView)
        navigationController.pushViewController(vc, animated: true)
    }

}
