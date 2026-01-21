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
    private let partnerDetailService: PartnerDetailServiceProtocol

    // MARK: - Init
    init(
        organizationPageId: Int,
        organizationItemId: Int,
        partnerDetailService: PartnerDetailServiceProtocol = PartnerDetailService()
    ) {
        self.organizationPageId = organizationPageId
        self.organizationItemId = organizationItemId
        self.partnerDetailService = partnerDetailService
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
        try await partnerDetailService.fetchDetails(pageId: organizationPageId)
    }

    private func fetchOffers() async throws -> [OfferModel] {
        try await partnerDetailService.fetchOffers(itemId: organizationItemId)
    }
}

