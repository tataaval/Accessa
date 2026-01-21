//
//  OfferDetailViewModel.swift
//  Accessa
//
//  Created by Tatarella on 10.01.26.
//

import Combine
import Foundation

final class OfferDetailViewModel: ObservableObject {

    // MARK: - Published Properties
    @Published var offer: OfferDetailModel?
    @Published var media: [MediaItem] = []
    @Published var attributedDescription: AttributedString?

    @Published var isLoading = false
    @Published var errorMessage: String?

    // MARK: - Private Properties
    private let offerId: Int
    private let offerDetailService: OfferDetailServiceProtocol

    // MARK: - Init
    init(offerId: Int, offerDetailService: OfferDetailServiceProtocol = OfferDetailService()) {
        self.offerId = offerId
        self.offerDetailService = offerDetailService
    }

    // MARK: - Load Functions
    func loadAllData() async {
        isLoading = true
        errorMessage = nil

        do {
            async let offerTask = fetchOfferDetails()
            async let mediaTask = fetchMediaItems()

            let (offerResult, mediaResult) = try await (offerTask, mediaTask)
            
            let description = offerResult.descriptionHTML?.htmlToAttributedString

            self.offer = offerResult
            self.media = mediaResult
            self.attributedDescription = description
            
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }

    private func fetchOfferDetails() async throws -> OfferDetailModel {
        try await offerDetailService.fetchDetails(offerId: offerId)
    }

    private func fetchMediaItems() async throws -> [MediaItem] {
        try await offerDetailService.fetchMedia(offerId: offerId)
    }
}
