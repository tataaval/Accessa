//
//  QuickSettings.swift
//  Accessa
//
//  Created by Tatarella on 14.01.26.
//

import SwiftUI

struct QuickSettings: View {
    //MARK: - Properties
    let onEditProfile: () -> Void
    let onEditPassword: () -> Void

    //MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Quick Settings")
                .font(.app(size: .lg, weight: .semibold))
                .foregroundStyle(.colorGray900)
                .padding(.horizontal)
            VStack(spacing: 0) {
                SettingItem(
                    icon: "person",
                    title: "Profile Info",
                    onTap: onEditProfile
                )
                Divider()
                SettingItem(
                    icon: "lock",
                    title: "Password",
                    onTap: onEditPassword
                )
            }
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .padding(.horizontal)
        }
    }
}
