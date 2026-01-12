//
//  ImageItem.swift
//  Accessa
//
//  Created by Tatarella on 08.01.26.
//

import Kingfisher
import SwiftUI

struct ImageItem: View {
    //MARK: - Properties
    let image: String
    var targetSize: CGSize = CGSize(width: 400, height: 400)
    @State private var didFail = false

    //MARK: - Body
    var body: some View {
        ZStack {
            if didFail {
                ImagePlaceholder()
            } else {
                KFImage(URL(string: image))
                    .setProcessor(DownsamplingImageProcessor(size: targetSize))
                    .scaleFactor(UIScreen.main.scale)
                    .serialize(by: DefaultCacheSerializer.default)
                    .retry(maxCount: 1, interval: .seconds(2))
                    .fade(duration: 0.3)
                    .onFailure { _ in didFail = true }
                    .placeholder { loadingView }
                    .resizable()
                    .scaledToFill()
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    .clipped()
            }
        }
    }

    //MARK: - Helper Views
    private var loadingView: some View {
        ZStack {
            Color.gray.opacity(0.1)
            ProgressView()
                .progressViewStyle(.circular)
                .tint(.colorPrimary)
        }
    }
}
