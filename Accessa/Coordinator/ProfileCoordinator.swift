//
//  ProfileCoordinator.swift
//  Accessa
//
//  Created by Tatarella on 03.01.26.
//

import SwiftUI
import UIKit

protocol ProfileRouter {
    func editProfile()
    func changePassword()
    func logout()
}

final class ProfileCoordinator: Coordinator, ProfileRouter {

    var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    private let container: AppContainer
    private let sessionService: SessionServiceProtocol

    var onLogout: (() -> Void)?

    init(
        navigationController: UINavigationController,
        container: AppContainer
    ) {
        self.navigationController = navigationController
        self.container = container
        
        self.sessionService = container.container.resolve(SessionServiceProtocol.self)
    }

    func start() {
        let viewModel = container.container.resolve(ProfileViewModel.self)
        let view = ProfileView(viewModel: viewModel, router: self)
        let vc = UIHostingController(rootView: view)
        navigationController.setViewControllers([vc], animated: false)
    }

    func editProfile() {
        let viewModel = container.container.resolve(EditProfileViewModel.self)
        let view = EditProfileView(viewModel: viewModel)
        push(view)
    }

    func changePassword() {
        let viewModel = container.container.resolve(ChangePasswordViewModel.self)
        let view = ChangePasswordView(viewModel: viewModel)
        push(view)
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
