//
//  ImagePlaceholder.swift
//  Accessa
//
//  Created by Tatarella on 08.01.26.
//

import SwiftUI

struct ImagePlaceholder: View {

    var body: some View {
        LinearGradient(
            colors: [
                Color.colorPrimary,
                Color.colorSecondary,
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )

    }
}
