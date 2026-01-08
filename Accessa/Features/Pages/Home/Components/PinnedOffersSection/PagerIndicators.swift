//
//  PagerIndicators.swift
//  Accessa
//
//  Created by Tatarella on 08.01.26.
//

import SwiftUI

struct PagerIndicators: View {
    //MARK: - Properties
    let count: Int
    let currentIndex: Int

    //MARK: - Body
    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<count, id: \.self) { index in
                Capsule()
                    .fill(index == currentIndex ? Color.colorPrimary : Color.gray.opacity(0.3))
                    .frame(
                        width: index == currentIndex ? 24 : 6,
                        height: 6
                    )
                    .animation(.easeInOut, value: currentIndex)
            }
        }
        .padding(.top, 4)
    }
}
