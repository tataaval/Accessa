//
//  OfferDetailsCarouselView.swift
//  Accessa
//
//  Created by Tatarella on 10.01.26.
//

import SwiftUI

struct OfferDetailsCarouselView: View {

    let images: [MediaItem]
    let discount: String

    @State private var index: Int = 0

    var body: some View {
        VStack(spacing: 12) {
            if images.isEmpty {
                ImagePlaceholder()
                    .frame(height: 320)
                    .clipped()
            } else {
                heroImage
                thumbnails
            }
        }
    }
}

private extension OfferDetailsCarouselView {
    var heroImage: some View {
        ZStack {

            ImageItem(image: images[index].thumbnailLg)
                .frame(height: 320)
                .clipped()
            
            discountBadge
            carouselnav
            pagination
        }

    }

    var discountBadge: some View {
        VStack {
            HStack {
                Text(discount)
                    .font(.app(size: .lg, weight: .bold))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 18)
                    .padding(.vertical, 12)
                    .background(.colorError)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .padding(.leading, 16)
                    .padding(.top, 12)

                Spacer()
            }
            Spacer()
        }
    }

    var carouselnav: some View {
        HStack {
            navButton(icon: "chevron.left") {
                index = max(index - 1, 0)
            }
            .opacity(index == 0 ? 0.35 : 1)

            Spacer()

            navButton(icon: "chevron.right") {
                index = min(index + 1, images.count - 1)
            }
            .opacity(index == images.count - 1 ? 0.35 : 1)
        }
        .padding(.horizontal, 16)
    }

    var pagination: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Text("\(index + 1) / \(images.count)")
                    .font(.app(size: .base))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 8)
                    .background(.black.opacity(0.55))
                    .clipShape(Capsule())
                    .padding(.trailing, 16)
                    .padding(.bottom, 8)
            }
        }
    }

    var thumbnails: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(images.indices, id: \.self) { i in
                    Button {
                        withAnimation(.easeInOut) {
                            index = i
                        }
                    } label: {
                        ImageItem(image: images[i].thumbnailSm)
                            .frame(width: 64, height: 64)
                            .clipped()
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(
                                        i == index
                                            ? Color.colorPrimary : .clear,
                                        lineWidth: 3
                                    )
                            )
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 4)
        }
    }

    func navButton(icon: String, action: @escaping () -> Void)
        -> some View
    {
        Button(action: action) {
            Image(systemName: icon)
                .foregroundStyle(.colorPrimary)
                .frame(width: 46, height: 46)
                .background(.white.opacity(0.9))
                .clipShape(Circle())
                .shadow(color: .black.opacity(0.12), radius: 10, x: 0, y: 4)
        }
        .buttonStyle(.plain)
    }
}
