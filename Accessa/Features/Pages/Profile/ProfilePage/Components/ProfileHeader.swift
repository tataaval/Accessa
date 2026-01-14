//
//  ProfileHeader.swift
//  Accessa
//
//  Created by Tatarella on 14.01.26.
//

import SwiftUI

struct ProfileHeader: View {
    var body: some View {
        ZStack(alignment: .center) {
            Color.colorPrimary
            Text("Profile")
                .font(.app(size: .xl, weight: .bold))
                .foregroundStyle(.white)
                .padding(.top, 30)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 180)
    }
}

