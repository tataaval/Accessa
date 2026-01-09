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
        isLoading = true
        errorMessage = nil

        do {
            async let pinned = fetchPinnedOffers()
            async let orgs = fetchOrganizations()
            async let lastChance = fetchLastChanceOffers()

            pinnedOffers = try await pinned
            organizations = try await orgs
            lastChanceOffers = try await lastChance
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }

    func fetchPinnedOffers() async throws -> [OfferModel] {
        let response: PinnedOffersResponseModel =
            try await networkService.fetch(from: API.pinnedOffers(limit: 5))
        return response.data
    }

    func fetchOrganizations() async throws -> [OrganizationItemModel] {
        let response: OrganizationsResponseModel =
            try await networkService.fetch(from: API.organizations(limit: 6))
        return response.data
    }

    func fetchLastChanceOffers() async throws -> [OfferModel] {
        let response: OffersResponseModel =
            try await networkService.fetch(from: API.discounts(limit: 6))
        return response.data
    }

}
