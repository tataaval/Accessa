//
//  MapFilterSheet.swift
//  Accessa
//
//  Created by Tatarella on 23.01.26.
//

import SwiftUI

struct MapFilterSheet: View {
    //MARK: - Properties
    @Binding var filters: MapFilters

    private let categoryColumns: [GridItem] = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10),
    ]

    //MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {

            VStack(alignment: .leading, spacing: 6) {
                Text("Search & Filters")
                    .font(.app(size: .lg, weight: .bold))
                    .foregroundStyle(.colorGray900)

                Text("Find offers faster")
                    .font(.app(size: .base))
                    .foregroundStyle(.colorGray500)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            SearchField(
                text: $filters.searchText,
                placeholder: "Offer Name or Organization"
            )
            .frame(maxWidth: .infinity)

            VStack(alignment: .leading, spacing: 12) {
                Text("Discount")
                    .font(.app(size: .base, weight: .bold))
                    .foregroundStyle(.colorGray900)

                HStack(spacing: 10) {
                    ForEach(DiscountFilter.allCases) { item in
                        CategoryChip(
                            title: item.rawValue,
                            isSelected: filters.discountFilter == item
                        ) {
                            filters.discountFilter = item
                        }
                    }
                    Spacer()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            VStack(alignment: .leading, spacing: 12) {
                Text("Category")
                    .font(.app(size: .base, weight: .bold))
                    .foregroundStyle(.colorGray900)

                LazyVGrid(columns: categoryColumns, spacing: 10) {
                    CategoryChip(
                        title: "All",
                        isSelected: filters.category == nil
                    ) {
                        filters.category = nil
                    }

                    ForEach(OfferCategory.allCases) { item in
                        CategoryChip(
                            title: item.title,
                            isSelected: filters.category == item
                        ) {
                            filters.category = item
                        }
                    }
                }
            }

            Spacer()

            AppButton(title: "Reset Filter", isLoading: false) {
                filters = MapFilters()
            }
            .frame(maxWidth: .infinity)
        }
        .padding(.horizontal, 20)
        .padding(.top, 20)
        .padding(.bottom, 24)
        .frame(maxWidth: .infinity, alignment: .leading)
    }

}
