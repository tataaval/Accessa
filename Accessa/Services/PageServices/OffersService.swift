//
//  OffersService.swift
//  Accessa
//
//  Created by Tatarella on 21.01.26.
//

protocol OffersServiceProtocol {
    func fetchCategories() async throws -> [CategoryModel]
    func fetchOffers(page: Int, limit: Int, search: String?, categoryId: Int?)
        async throws -> (data: [OfferModel], meta: PaginationMetaModel)
}

final class OffersService: OffersServiceProtocol {
    private let network: NetworkServiceProtocol

    init(network: NetworkServiceProtocol = NetworkService.shared) {
        self.network = network
    }

    func fetchCategories() async throws -> [CategoryModel] {
        let response: CategoriesResponseModel = try await network.fetch(from: CategoriesAPI.categories)
        return response.data
    }

    func fetchOffers(page: Int, limit: Int, search: String?, categoryId: Int?) async throws -> (data: [OfferModel], meta: PaginationMetaModel) {
        let api = DiscountsAPI.discounts(
            limit: limit,
            page: page,
            searchKeyword: search,
            organisationId: nil,
            categoryId: categoryId
        )
        let response: OffersResponseModel = try await network.fetch(from: api)
        return (response.data, response.meta)
    }
}
