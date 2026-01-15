//
//  FormHeader.swift
//  Accessa
//
//  Created by Tatarella on 15.01.26.
//

import SwiftUI

struct FormHeader: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Change Password")
                .font(.app(size: .xl, weight: .bold))

            Text("Keep your account secure by updating your password regularly")
                .font(.app(size: .base))
                .foregroundColor(.secondary)
        }
        .padding(.horizontal)
    }
}
