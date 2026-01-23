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
                        let isSelected = filters.discountFilter == item

                        Button {
                            filters.discountFilter = item
                        } label: {
                            Text(item.rawValue)
                                .font(.app(size: .sm, weight: .bold))
                                .foregroundStyle(
                                    isSelected
                                        ? Color.white : Color.colorGray900
                                )
                                .padding(.vertical, 10)
                                .padding(.horizontal, 14)
                                .background(
                                    isSelected
                                        ? Color.colorPrimary : Color.white
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 999)
                                        .stroke(
                                            isSelected
                                                ? Color.clear
                                                : Color.colorGray300,
                                            lineWidth: 1
                                        )
                                )
                                .clipShape(Capsule())
                        }
                        .buttonStyle(.plain)
                    }

                    Spacer()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

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
