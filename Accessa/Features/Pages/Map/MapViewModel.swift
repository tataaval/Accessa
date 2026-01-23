//
//  MapViewModel.swift
//  Accessa
//
//  Created by Tatarella on 21.01.26.
//

import Combine
import CoreLocation
import Foundation

enum DiscountFilter: String, CaseIterable, Identifiable {
    case all = "All"
    case low = "10%+"
    case medium = "20%+"
    case high = "50%+"

    var id: String { rawValue }

    func matches(discount: Int) -> Bool {
        switch self {
        case .all: return true
        case .low: return discount >= 10
        case .medium: return discount >= 20
        case .high: return discount >= 50
        }
    }
}

struct MapFilters {
    var searchText: String = ""
    var discountFilter: DiscountFilter = .all
}

final class MapViewModel: ObservableObject {
    //MARK: - Published Properties
    @Published var offers: [OfferMapItem] = []
    @Published var filters = MapFilters()
    
    @Published var searchText: String = ""
    
    @Published var errorMessage: String?
    
    //MARK: - Private Properties
    private var cancellables = Set<AnyCancellable>()
    
    var filteredOffers: [OfferMapItem] {
           offers.filter { offer in
               let search = filters.searchText.trimmingCharacters(in: .whitespacesAndNewlines)

               let matchesSearch: Bool = {
                   guard !search.isEmpty else { return true }
                   return offer.title.localizedCaseInsensitiveContains(search) ||
                          offer.organization.localizedCaseInsensitiveContains(search)
               }()

               let matchesDiscount = filters.discountFilter.matches(discount: offer.discount)

               return matchesSearch && matchesDiscount
           }
       }

    //MARK: - Init
    init() {
        loadOffers()
        bindSearch()
    }

    //MARK: - Load Function
    func loadOffers() {
        guard
            let url = Bundle.main.url(forResource: "mapOffers", withExtension: "json")
        else {
            print("no json file")
            return
        }

        do {
            let data = try Data(contentsOf: url)
            let decoded = try JSONDecoder().decode([Offer].self, from: data)
            self.offers = decoded.map { OfferMapItem(offer: $0) }
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
    
    //MARK: - bind search inupt
    private func bindSearch() {
          $filters
              .map { $0.searchText }
              .removeDuplicates()
              .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
              .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
              .removeDuplicates()
              .sink { [weak self] text in
                  self?.searchText = text
              }
              .store(in: &cancellables)
      }
}
