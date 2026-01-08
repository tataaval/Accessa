//
//  HeaderView.swift
//  Accessa
//
//  Created by Tatarella on 08.01.26.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Color.colorPrimary

            VStack(alignment: .leading, spacing: 16) {
                Text("You can Accessa a lot")
                    .font(.app(size: .xl, weight: .bold))
                    .foregroundStyle(.white)

                Text("Discover offers and partners")
                    .font(.app(size: .lg))
                    .foregroundStyle(.white.opacity(0.9))
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 24)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 180)
    }
}
