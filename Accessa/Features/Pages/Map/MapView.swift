//
//  MapView.swift
//  Accessa
//
//  Created by Tatarella on 21.01.26.
//

import SwiftUI

struct MapView: View {

    //MARK: - State object
    @StateObject private var viewModel = MapViewModel()
    
    //MARK: - properties
    @State private var selectedOffer: OfferMapItem? = nil
    let router: OfferRouting

    //MARK: - Body
    var body: some View {
        ClusteredMapView(offers: viewModel.offers) { offer in
            withAnimation(.spring()) {
                self.selectedOffer = offer
            }
        }
        .ignoresSafeArea()
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
                .transition(.move(edge: .bottom))
            }
        }
    }

}

