//
//  OfferDetailService.swift
//  Accessa
//
//  Created by Tatarella on 21.01.26.
//

protocol OfferDetailServiceProtocol {
    func fetchDetails(offerId: Int) async throws -> OfferDetailModel
    func fetchMedia(offerId: Int) async throws -> [MediaItem]
}

final class OfferDetailService: OfferDetailServiceProtocol {
    private let network: NetworkServiceProtocol

    init(network: NetworkServiceProtocol = NetworkService.shared) {
        self.network = network
    }

    func fetchDetails(offerId: Int) async throws -> OfferDetailModel {
        let api = DiscountsAPI.discountDetails(id: offerId)
        return try await network.fetch(from: api)
    }

    func fetchMedia(offerId: Int) async throws -> [MediaItem] {
        let api = MediaAPI.mediaItems(id: offerId)
        let response: MediaResponse = try await network.fetch(from: api)
        return response.data
    }
}
