//
//  HomeViewModel.swift
//  Accessa
//
//  Created by Tatarella on 08.01.26.
//

import Combine
import Foundation

final class HomeViewModel: ObservableObject {

    // MARK: - Published Properties
    @Published var pinnedOffers: [OfferModel] = []
    @Published var organizations: [OrganizationItemModel] = []
    @Published var lastChanceOffers: [OfferModel] = []

    @Published var isLoading = false
    @Published var errorMessage: String?

    // MARK: - Private Properties
    private let networkService: NetworkServiceProtocol

    // MARK: - Init
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }

    // MARK: - Load Functions
    func loadAllData() async {
        guard pinnedOffers.isEmpty else { return }
        
        isLoading = true
        errorMessage = nil

        do {
            async let pinnedTask = fetchPinnedOffers()
            async let orgTask = fetchOrganizations()
            async let lastChanceTask = fetchLastChanceOffers()

            let (pinned, orgs, lastChance) = try await (pinnedTask, orgTask, lastChanceTask)
            
            self.pinnedOffers = pinned
            self.organizations = orgs
            self.lastChanceOffers = lastChance
            
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }

    private func fetchPinnedOffers() async throws -> [OfferModel] {
        let response: PinnedOffersResponseModel =
            try await networkService.fetch(from: DiscountsAPI.pinnedOffers(limit: 5))
        return response.data
    }

    private func fetchOrganizations() async throws -> [OrganizationItemModel] {
        let response: OrganizationsResponseModel =
            try await networkService.fetch(from: OrganizationsAPI.organizations(limit: 6))
        return response.data
    }

    private func fetchLastChanceOffers() async throws -> [OfferModel] {
        let response: OffersResponseModel =
            try await networkService.fetch(from: DiscountsAPI.discounts(limit: 6))
        return response.data
    }

}
