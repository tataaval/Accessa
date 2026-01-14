//
//  SettingItem.swift
//  Accessa
//
//  Created by Tatarella on 14.01.26.
//

import SwiftUI

struct SettingItem: View {
    //MARK: - properties
    let icon: String
    let title: String
    let onTap: () -> Void

    //MARK: - body
    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 16) {
                Image(systemName: icon)
                    .frame(width: 24)
                    .foregroundColor(.colorGray500)
                Text(title)
                    .font(.app(size: .base, weight: .semibold))
                    .foregroundColor(.colorGray900)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.colorGray500)
            }
            .padding()
        }
    }
}
