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
    private let homeService: HomeServiceProtocol
    private let offerDetailService: OfferDetailServiceProtocol
    private let partnerDetailService: PartnerDetailServiceProtocol

    init(
        navigationController: UINavigationController,
        homeService: HomeServiceProtocol = HomeService(),
        offerDetailService: OfferDetailServiceProtocol = OfferDetailService(),
        partnerDetailService: PartnerDetailServiceProtocol =
            PartnerDetailService()
    ) {
        self.navigationController = navigationController
        self.homeService = homeService
        self.offerDetailService = offerDetailService
        self.partnerDetailService = partnerDetailService
    }

    func start() {
        let viewModel = HomeViewModel(homeService: homeService)
        let view = HomeView(viewModel: viewModel, router: self)
        let vc = UIHostingController(rootView: view)
        navigationController.setViewControllers([vc], animated: false)
    }

    func openOffer(id: Int) {
        let viewModel = OfferDetailViewModel(
            offerId: id,
            offerDetailService: offerDetailService
        )
        let view = OfferDetailView(viewModel: viewModel)
        push(view)
    }

    func openOrganization(organizationPageId: Int, organizationItemId: Int) {

        let viewModel = PartnerDetailViewModel(
            organizationPageId: organizationPageId,
            organizationItemId: organizationItemId,
            partnerDetailService: partnerDetailService
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
