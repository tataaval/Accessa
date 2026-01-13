//
//  OrganizationsSection.swift
//  Accessa
//
//  Created by Tatarella on 08.01.26.
//

import SwiftUI

struct OrganizationsSection: View {
    //MARK: - Properties
    let organizations: [OrganizationItemModel]
    let seeOrganizationDetails: (_ organizationPageId: Int, _ organizationItemId: Int) -> Void

    //MARK: - Grid Layout
    let columns = Array(repeating: GridItem(.flexible(), spacing: 16), count: 3)

    //MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            sectionHeader
            organizationsSection
        }
    }
}

private extension OrganizationsSection {
    var sectionHeader: some View {
        HStack {
            Text("Partner Organizations")
                .font(.app(size: .lg, weight: .semibold))
                .foregroundColor(.colorGray900)
            Spacer()
        }
        .padding(.horizontal)
    }

    var organizationsSection: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            ForEach(organizations) { organization in
                OrganizationCard(
                    organization: organization,
                    seeOrganizationDetails: seeOrganizationDetails
                )
            }
        }
        .padding(.horizontal)
    }
}
