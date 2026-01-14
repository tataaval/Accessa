//
//  ActionButtons.swift
//  Accessa
//
//  Created by Tatarella on 14.01.26.
//

import SwiftUI

struct ActionButtons: View {
    //MARK: - Properties
    let onLogout: () -> Void
    let onDeleteProfile: () -> Void

    //MARK: - Body
    var body: some View {
        VStack {
            ActionButton(
                title: "Logout",
                icon: "rectangle.portrait.and.arrow.right",
                onTap: onLogout
            )
            ActionButton(
                title: "Delete Profile",
                icon: "person.fill.xmark",
                onTap: onDeleteProfile
            )
        }
    }
}
