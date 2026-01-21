//
//  PartnerDetailService.swift
//  Accessa
//
//  Created by Tatarella on 21.01.26.
//

protocol PartnerDetailServiceProtocol {
    func fetchDetails(pageId: Int) async throws -> OrganizationDetailModel
    func fetchOffers(itemId: Int) async throws -> [OfferModel]
}

final class PartnerDetailService: PartnerDetailServiceProtocol {
    private let network: NetworkServiceProtocol

    init(network: NetworkServiceProtocol = NetworkService.shared) {
        self.network = network
    }

    func fetchDetails(pageId: Int) async throws -> OrganizationDetailModel {
        let api = OrganizationsAPI.organizationDetails(id: pageId)
        return try await network.fetch(from: api)
    }

    func fetchOffers(itemId: Int) async throws -> [OfferModel] {
        let api = DiscountsAPI.discounts(limit: 4, organisationId: itemId)
        let response: OffersResponseModel = try await network.fetch(from: api)
        return response.data
    }
}
