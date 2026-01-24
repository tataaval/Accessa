//
//  ProfileViewModel.swift
//  Accessa
//
//  Created by Tatarella on 14.01.26.
//

import Combine
import Foundation

final class ProfileViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var cardInfo: CardInfoModel?

    @Published var isLoading = false
    @Published var errorMessage: String?

    // MARK: - Private Properties
    private let profileService: ProfileServiceProtocol

    // MARK: - Init
    init(profileService: ProfileServiceProtocol) {
        self.profileService = profileService
    }

    // MARK: - Load Functions
    func loadData() async {
        guard cardInfo == nil else { return }

        isLoading = true
        errorMessage = nil

        do {
            self.cardInfo = try await profileService.fetchCardInfo()

        } catch {
            errorMessage = error.localizedDescription
            print(error)
        }

        isLoading = false
    }

    //MARK: - Profile delete
    func deleteProfile() async {
        isLoading = true
        errorMessage = nil

        do {
            try await profileService.deleteAccount()
            cardInfo = nil
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false

    }
}
