//
//  ProfileCoordinator.swift
//  Accessa
//
//  Created by Tatarella on 03.01.26.
//


import UIKit
import SwiftUI

protocol ProfileRouter {
    func editProfile()
    func changePassword()
    func logout()
}

final class ProfileCoordinator: Coordinator, ProfileRouter {

    var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    private let sessionService: SessionServiceProtocol

    var onLogout: (() -> Void)?

    init(
        navigationController: UINavigationController,
        sessionService: SessionServiceProtocol
    ) {
        self.navigationController = navigationController
        self.sessionService = sessionService
    }

    func start() {
        let view = ProfileView(router: self)
        let vc = UIHostingController(rootView: view)
        navigationController.setViewControllers([vc], animated: false)
    }

    func editProfile() {
        push(EditProfileView())
    }

    func changePassword() {
        push(ChangePasswordView())
    }

    func logout() {
        try? sessionService.clearSession()
        onLogout?()
    }

    private func push<V: View>(_ view: V) {
        navigationController.pushViewController(
            UIHostingController(rootView: view),
            animated: true
        )
    }
}

