//
//  FormHeader.swift
//  Accessa
//
//  Created by Tatarella on 15.01.26.
//

import SwiftUI

struct FormHeader: View {
    
    let title: String
    var subtitle: String? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.app(size: .xl, weight: .bold))
                .foregroundColor(.colorGray900)

            if let subtitle {
                Text(subtitle)
                    .font(.app(size: .base))
                    .foregroundColor(.colorGray500)
            }
        }
        .padding(.horizontal)
    }
}
