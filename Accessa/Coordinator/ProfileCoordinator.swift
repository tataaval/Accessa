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
    private let sessionService: SessionServiceProtocol
    private let profileService: ProfileServiceProtocol
    private let validationService: ValidationServiceProtocol

    var onLogout: (() -> Void)?

    init(
        navigationController: UINavigationController,
        sessionService: SessionServiceProtocol,
        profileService: ProfileServiceProtocol,
        validationService: ValidationServiceProtocol
    ) {
        self.navigationController = navigationController
        self.sessionService = sessionService
        self.profileService = profileService
        self.validationService = validationService
    }

    func start() {
        let viewModel = ProfileViewModel(profileService: profileService)
        let view = ProfileView(viewModel: viewModel, router: self)
        let vc = UIHostingController(rootView: view)
        navigationController.setViewControllers([vc], animated: false)
    }

    func editProfile() {
        let viewModel = EditProfileViewModel(
            profileService: profileService,
            validationService: validationService
        )
        let view = EditProfileView(viewModel: viewModel)
        push(view)
    }

    func changePassword() {
        let viewModel = ChangePasswordViewModel(
            profileService: profileService,
            validationService: validationService
        )
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
