//
//  LoadingOverlay.swift
//  Accessa
//
//  Created by Tatarella on 11.01.26.
//

import SwiftUI

struct LoadingOverlay: View {
    //MARK: - Properties
    let text: String

    //MARK: - Body
    var body: some View {
        VStack {
            ProgressView()
                .scaleEffect(1.5)

            Text(text)
                .font(.app(size: .sm))
                .foregroundColor(.gray)
                .padding(.top, 8)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.colorGray200)
    }
}
