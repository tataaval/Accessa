//
//  ImageItem.swift
//  Accessa
//
//  Created by Tatarella on 08.01.26.
//

import SwiftUI
import Kingfisher

struct ImageItem: View {
    var image: String
    
    var body: some View {
        KFImage(URL(string: image))
            .placeholder {
                ZStack {
                    Color.gray.opacity(0.1)
                    ProgressView()
                        .progressViewStyle(.circular)
                        .tint(.colorPrimary)
                }
            }
            .retry(maxCount: 3, interval: .seconds(2))
            .onFailure { error in
                print("Job failed: \(error.localizedDescription)")
            }
            .fade(duration: 0.3)
            .resizable()
            .scaledToFill()
            .clipped()
    }
}
