//
//  PinnedOffersSection.swift
//  Accessa
//
//  Created by Tatarella on 08.01.26.
//

import SwiftUI

struct PinnedOffersSection: View {
    //MARK: - Properties
    @State private var currentIndex = 0

    let offers: [OfferModel]
    let seeDetails: (_ offerId: Int) -> Void

    //MARK: - Body
    var body: some View {
        VStack(spacing: 12) {
            sectionHeader
            offersCarousel
            pagerIndicators
        }
    }

    // MARK: - Calculated Properties
    private var isFirst: Bool { currentIndex == 0 }
    private var isLast: Bool { currentIndex == max(0, offers.count - 1) }

    // MARK: - Helper Functions
    private func moveLeft(proxy: ScrollViewProxy) {
        guard !isFirst else { return }
        withAnimation(.easeInOut) {
            currentIndex -= 1
            proxy.scrollTo(currentIndex, anchor: .center)
        }
    }

    private func moveRight(proxy: ScrollViewProxy) {
        guard !isLast else { return }
        withAnimation(.easeInOut) {
            currentIndex += 1
            proxy.scrollTo(currentIndex, anchor: .center)
        }
    }
}

extension PinnedOffersSection {
    fileprivate var sectionHeader: some View {
        ScrollViewReader { proxy in
            HStack {
                Text("Pinned Offers")
                    .font(.app(size: .lg, weight: .semibold))
                    .foregroundStyle(.colorGray900)

                Spacer()

                chevronLeft(proxy: proxy)
                chevronRight(proxy: proxy)
            }
            .padding(.horizontal)
        }
    }

    fileprivate func chevronLeft(proxy: ScrollViewProxy) -> some View {
        Button {
            moveLeft(proxy: proxy)
        } label: {
            Image(systemName: "chevron.left")
                .frame(width: 32, height: 32)
                .background(.white)
                .clipShape(Circle())
                .shadow(radius: 2)
                .foregroundStyle(isFirst ? .gray : .colorPrimary)
        }
        .disabled(isFirst)
    }

    fileprivate func chevronRight(proxy: ScrollViewProxy) -> some View {
        Button {
            moveRight(proxy: proxy)
        } label: {
            Image(systemName: "chevron.right")
                .frame(width: 32, height: 32)
                .background(.white)
                .clipShape(Circle())
                .shadow(radius: 2)
                .foregroundStyle(isLast ? .gray : .colorPrimary)
        }
        .disabled(isLast)
    }

    fileprivate var offersCarousel: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 12) {
                ForEach(offers.indices, id: \.self) { index in
                    PinnedOfferCard(
                        offer: offers[index],
                        seeDetails: seeDetails
                    )
                    .containerRelativeFrame(.horizontal) { size, axis in
                        size * 0.85
                    }
                    .id(index)
                }
            }
            .scrollTargetLayout()
            .padding(.horizontal, 24)
        }
        .scrollTargetBehavior(.viewAligned)
        .scrollPosition(
            id: Binding(
                get: { currentIndex },
                set: { newIndex in
                    if let newIndex { currentIndex = newIndex }
                }
            )
        )
        .frame(height: 340)
    }

    fileprivate var pagerIndicators: some View {
        PagerIndicators(
            count: offers.count,
            currentIndex: currentIndex
        )
    }
}
