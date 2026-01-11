//
//  LoadMoreButton.swift
//  Accessa
//
//  Created by Tatarella on 11.01.26.
//

import SwiftUI

struct LoadMoreButton: View {
    //MARK: - Properties
    let isLoading: Bool
    let action: () -> Void

    //MARK: - Body
    var body: some View {
        Button(action: action) {
            ZStack {
                Text("Load more")
                    .font(.app(size: .lg, weight: .semibold))
                    .opacity(isLoading ? 0 : 1)

                if isLoading {
                    ProgressView().tint(.white)
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 54)
        }
        .background(Color.colorPrimary)
        .foregroundStyle(.white)
        .cornerRadius(12)
        .padding(.horizontal)
        .disabled(isLoading)
    }
}
