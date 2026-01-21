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
    private let homeService: HomeServiceProtocol

    // MARK: - Init
    init(homeService: HomeServiceProtocol = HomeService()) {
        self.homeService = homeService
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
        try await homeService.fetchPinnedOffers(limit: 6)
    }

    private func fetchOrganizations() async throws -> [OrganizationItemModel] {
        try await homeService.fetchTopOrganizations(limit: 6)
    }

    private func fetchLastChanceOffers() async throws -> [OfferModel] {
        try await homeService.fetchLastChanceOffers(limit: 6)
    }
}
