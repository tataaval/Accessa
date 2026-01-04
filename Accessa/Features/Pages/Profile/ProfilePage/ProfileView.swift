//
//  ProfileView.swift
//  Accessa
//
//  Created by Tatarella on 03.01.26.
//

import SwiftUI

struct ProfileView: View {
    let router: ProfileRouter

    var body: some View {
        VStack {
            Button("Edit Profile", action: router.editProfile)
            Button("Change Password", action: router.changePassword)
            Button("Logout", role: .destructive, action: router.logout)
        }
        .navigationTitle("Profile")
    }
}
