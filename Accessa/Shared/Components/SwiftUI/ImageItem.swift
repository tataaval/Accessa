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
    @State private var didFail = false

    //MARK: - Body
    var body: some View {
        ZStack {
            if didFail {
                ImagePlaceholder()
            } else {
                KFImage(URL(string: image))
                    .placeholder {
                        loadingView
                    }
                    .retry(maxCount: 1, interval: .seconds(2))
                    .onFailure { _ in
                        didFail = true
                    }
                    .fade(duration: 0.3)
                    .resizable()
                    .scaledToFill()
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
