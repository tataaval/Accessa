//
//  PartnerDetailViewModel.swift
//  Accessa
//
//  Created by Tatarella on 12.01.26.
//

import Combine
import Foundation

final class PartnerDetailViewModel: ObservableObject {

    // MARK: - Published Properties
    @Published var organization: OrganizationDetailModel?
    @Published var offers: [OfferModel] = []
    @Published var attributedDescription: AttributedString?

    @Published var isLoading = false
    @Published var errorMessage: String?

    // MARK: - Private Properties
    private let organizationPageId: Int
    private let organizationItemId: Int
    private let networkService: NetworkServiceProtocol

    // MARK: - Init
    init(
        organizationPageId: Int,
        organizationItemId: Int,
        networkService: NetworkServiceProtocol
    ) {
        self.organizationPageId = organizationPageId
        self.organizationItemId = organizationItemId
        self.networkService = networkService
    }

    // MARK: - Load Functions
    func loadAllData() async {
        isLoading = true
        errorMessage = nil

        do {
            async let detailsTask = fetchOrganizationDetails()
            async let offersTaks = fetchOffers()

            let (detailsResult, offersResult) = try await (detailsTask, offersTaks)

            let description = detailsResult.descriptionHTML?.htmlToAttributedString

            self.organization = detailsResult
            self.offers = offersResult
            self.attributedDescription = description

        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }

    private func fetchOrganizationDetails() async throws -> OrganizationDetailModel {
        let response: OrganizationDetailModel =
            try await networkService.fetch(from: OrganizationsAPI.organizationDetails(id: organizationPageId))
        return response
    }

    private func fetchOffers() async throws -> [OfferModel] {
        let response: OffersResponseModel =
            try await networkService.fetch(from: DiscountsAPI.discounts( limit: 4, organisationId: organizationItemId))
        return response.data
    }

}
