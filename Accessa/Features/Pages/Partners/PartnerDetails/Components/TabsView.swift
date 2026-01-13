//
//  TabsView.swift
//  Accessa
//
//  Created by Tatarella on 13.01.26.
//

import SwiftUI

struct TabsView: View {
    //MARK: - properties
    let offers: [OfferModel]
    let about: AttributedString?
    let onSeeMore: (_ id: Int) -> Void
    @State var selectedTab: Int = 0

    //MARK: - Body
    var body: some View {
        VStack {
            tabView
            contentView
        }
    }
}

private extension TabsView {
    var tabView: some View {
        HStack(spacing: 24) {
            TabItem(id: 0, title: "Offers", selectedTab: $selectedTab)
            TabItem(id: 1, title: "About", selectedTab: $selectedTab)
        }
        .padding(.horizontal)
        .padding(.top)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.white)
        .overlay {
            Rectangle()
                .stroke(.colorGray300.opacity(0.6), lineWidth: 1)
        }
    }

    var contentView: some View {
        ZStack(alignment: .topLeading) {
            if selectedTab == 0 {
                offersView
            } else {
                aboutText
            }
        }
        .padding()
    }

    @ViewBuilder
    var offersView: some View {
        if offers.isEmpty {
            EmptyStateText(text: "No Offers Yet")
        } else {
            VStack(spacing: 12) {
                ForEach(offers) { offer in
                    OrganizationOffer(
                        offer: offer,
                        note: "Valid for Accessa cardholders only",
                        onSeeMore: onSeeMore
                    )
                }
            }
            .padding(.top, 8)
        }

    }

    @ViewBuilder
    var aboutText: some View {
        if let about = about {
            Text(about)
                .multilineTextAlignment(.leading)
        } else {
            Text("No Data")
        }
    }
}
