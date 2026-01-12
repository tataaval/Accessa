//
//  CoverView.swift
//  Accessa
//
//  Created by Tatarella on 12.01.26.
//

import SwiftUI

struct CoverView: View {
    //MARK: - properties
    let cover: String?

    //MARK: - Body
    var body: some View {
        ZStack {
            if let imageUrl = cover {
                ImageItem(image: imageUrl)
            } else {
                ImagePlaceholder()
            }
        }
        .frame(height: 120)
        .frame(maxWidth: .infinity)
        .clipShape(Rectangle())
    }

}
