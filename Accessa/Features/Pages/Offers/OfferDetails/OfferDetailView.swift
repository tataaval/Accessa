//
//  OfferDetailView.swift
//  Accessa
//
//  Created by Tatarella on 03.01.26.
//

import SwiftUI

struct OfferDetailView: View {
    //MARK: - StateObject
    @StateObject var viewModel: OfferDetailViewModel

    //MARK: - Body
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()

            if let offer = viewModel.offer {
                ScrollView {
                    VStack(alignment: .leading) {
                        OfferDetailsCarouselView(
                            images: viewModel.media,
                            discount: offer.discountText
                        )
                        CustomDivider()
                        DetailView(
                            title: offer.title,
                            organization: offer.organizationTitle,
                            endDate: offer.endDate,
                            location: offer.cityNames
                        )
                        CustomDivider()
                        AboutView(text: viewModel.attributedDescription)
                    }
                }
            } else {
                VStack {
                    ProgressView()
                        .scaleEffect(1.2)
                        .tint(.colorPrimary)
                    Text("Loading offer...")
                        .font(.app(size: .sm))
                        .foregroundStyle(.gray)
                        .padding(.top, 8)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .task {
            await viewModel.loadAllData()
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
                    await viewModel.loadAllData()
                }
            }
            Button("OK", role: .cancel) {}
        } message: {
            Text(viewModel.errorMessage ?? "An unknown error occurred")
        }
    }
}
