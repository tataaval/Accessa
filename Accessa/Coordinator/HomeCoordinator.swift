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
    func openOrganizations()
    func openOrganization(id: Int)
}

final class HomeCoordinator: Coordinator, HomeRouter {

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
        push(OfferDetailView(id: id))
    }

    func openOrganizations() {
        push(PartnerListView(router: self))
    }

    func openOrganization(id: Int) {
        push(PartnerDetailView(id: id))
    }

    private func push<V: View>(_ view: V) {
        navigationController.pushViewController(
            UIHostingController(rootView: view),
            animated: true
        )
    }
}
