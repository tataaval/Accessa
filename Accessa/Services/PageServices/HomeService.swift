//
//  HomeService.swift
//  Accessa
//
//  Created by Tatarella on 21.01.26.
//

protocol HomeServiceProtocol {
    func fetchPinnedOffers(limit: Int) async throws -> [OfferModel]
    func fetchTopOrganizations(limit: Int) async throws -> [OrganizationItemModel]
    func fetchLastChanceOffers(limit: Int) async throws -> [OfferModel]
}

final class HomeService: HomeServiceProtocol {
    private let network: NetworkServiceProtocol

    init(network: NetworkServiceProtocol = NetworkService.shared) {
        self.network = network
    }

    func fetchPinnedOffers(limit: Int) async throws -> [OfferModel] {
        let response: PinnedOffersResponseModel = try await network.fetch(from: DiscountsAPI.pinnedOffers(limit: limit))
        return response.data
    }

    func fetchTopOrganizations(limit: Int) async throws -> [OrganizationItemModel] {
        let response: OrganizationsResponseModel = try await network.fetch(
            from: OrganizationsAPI.organizations(
                limit: limit,
                page: 1,
                searchKeyword: nil
            )
        )
        return response.data
    }

    func fetchLastChanceOffers(limit: Int) async throws -> [OfferModel] {
        let response: OffersResponseModel = try await network.fetch(from: DiscountsAPI.discounts(limit: limit))
        return response.data
    }
}
