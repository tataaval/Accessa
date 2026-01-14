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
    private let networkService: NetworkServiceProtocol

    // MARK: - Init
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }

    // MARK: - Load Functions
    func loadData() async {
        guard cardInfo == nil else { return }

        isLoading = true
        errorMessage = nil

        do {
            async let cardInfoTask = fetchCardInfo()

            let result = try await cardInfoTask
            self.cardInfo = result

        } catch {
            errorMessage = error.localizedDescription
            print(error)
        }

        isLoading = false
    }

    private func fetchCardInfo() async throws -> CardInfoModel {
        let response: CardInfoModel =
            try await networkService.fetch(from: API.cardInfo)
        return response
    }

    //MARK: - Profile delete
    func deleteProfile() async {
        isLoading = true
        errorMessage = nil

        do {
            try await delete()
            cardInfo = nil
        } catch {
            errorMessage = error.localizedDescription
            print(error)

        }
        isLoading = false

    }

    private func delete() async throws {
        let _: DeleteProfileResponseModel =
            try await networkService.fetch(from: API.deleteProfile)
    }
}
