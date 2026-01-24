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
    private let partnerService: PartnerServiceProtocol
    private let partnerDetailService: PartnerDetailServiceProtocol
    private let offerDetailService: OfferDetailServiceProtocol

    init(
        navigationController: UINavigationController,
        partnerService: PartnerServiceProtocol = PartnerService(),
        partnerDetailService: PartnerDetailServiceProtocol =
            PartnerDetailService(),
        offerDetailService: OfferDetailServiceProtocol = OfferDetailService()
    ) {
        self.navigationController = navigationController
        self.partnerService = partnerService
        self.partnerDetailService = partnerDetailService
        self.offerDetailService = offerDetailService
    }

    func start() {
        let viewModel = PartnerListViewModel(partnerService: partnerService)
        let view = PartnerListView(viewModel: viewModel, router: self)
        let vc = UIHostingController(rootView: view)
        navigationController.setViewControllers([vc], animated: false)
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

        navigationController.pushViewController(
            UIHostingController(rootView: view),
            animated: true
        )
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
