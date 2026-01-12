//
//  OrganizationsList.swift
//  Accessa
//
//  Created by Tatarella on 11.01.26.
//

import SwiftUI

struct OrganizationsList: View {

    //MARK: - Properties
    let organizations: [OrganizationItemModel]
    let seeDetails: (_ organizationPageId: Int, _ organizationItemId: Int) -> Void

    //MARK: - Body
    var body: some View {

        LazyVStack(spacing: 16) {
            ForEach(organizations) { organization in
                OrganizationListCard(
                    organization: organization,
                    seeDetails: seeDetails
                )
            }
        }
        .padding(.horizontal)
    }
}
