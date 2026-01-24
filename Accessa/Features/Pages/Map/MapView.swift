//
//  MapView.swift
//  Accessa
//
//  Created by Tatarella on 21.01.26.
//

import SwiftUI

struct MapView: View {

    //MARK: - State object
    @StateObject var viewModel: MapViewModel 

    //MARK: - properties
    @State private var selectedOffer: OfferMapItem? = nil
    @State private var showFilters = false

    let router: OfferRouting

    //MARK: - Body
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ClusteredMapView(
                offers: viewModel.filteredOffers,
                onOfferTap: { offer in
                    withAnimation(.spring()) {
                        self.selectedOffer = offer
                    }
                },
                selectedOffer: $selectedOffer
            )
            .ignoresSafeArea()
            Button {
                showFilters = true
            } label: {
                Image(systemName: "magnifyingglass.circle.fill")
                    .font(.system(size: 40))
                    .foregroundStyle(.colorPrimary)
                    .padding(12)
                    .background(.white)
                    .clipShape(Circle())
            }
            .padding(.bottom, 16)
            .padding(.trailing, 16)
        }
        .overlay(alignment: .bottom) {
            if let selectedOffer {
                OfferPreviewCard(
                    title: selectedOffer.title,
                    discountText: selectedOffer.discountText,
                    organization: selectedOffer.organization,
                    onGoDetails: {
                        router.openOffer(id: selectedOffer.id)
                    },
                    onClose: {
                        withAnimation(.spring()) {
                            self.selectedOffer = nil
                        }
                    }
                )
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .alert(
            "Error",
            isPresented: Binding(
                get: { viewModel.errorMessage != nil },
                set: { _ in viewModel.errorMessage = nil }
            )
        ) {
            Button("Retry") {
                Task {
                    viewModel.loadOffers()
                }
            }
            Button("OK", role: .cancel) {}
        } message: {
            Text(viewModel.errorMessage ?? "An unknown error occurred")
        }
        .sheet(isPresented: $showFilters) {
            MapFilterSheet(filters: $viewModel.filters)
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.visible)
                .preferredColorScheme(.light)
                .presentationBackground(.white)
        }
    }
}
