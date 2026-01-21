//
//  PartnerService.swift
//  Accessa
//
//  Created by Tatarella on 21.01.26.
//

protocol PartnerServiceProtocol {
    func fetchOrganizations(page: Int, limit: Int, search: String?) async throws -> (data: [OrganizationItemModel], meta: PaginationMetaModel)
}

final class PartnerService: PartnerServiceProtocol {
    private let network: NetworkServiceProtocol

    init(network: NetworkServiceProtocol = NetworkService.shared) {
        self.network = network
    }

    func fetchOrganizations(page: Int, limit: Int, search: String?) async throws -> (data: [OrganizationItemModel], meta: PaginationMetaModel) {
        let api = OrganizationsAPI.organizations(
            limit: limit,
            page: page,
            searchKeyword: search
        )
        let response: OrganizationsResponseModel = try await network.fetch(from: api)
        return (response.data, response.meta)
    }
}
