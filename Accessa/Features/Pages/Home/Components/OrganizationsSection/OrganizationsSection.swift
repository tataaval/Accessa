//
//  OrganizationsSection.swift
//  Accessa
//
//  Created by Tatarella on 08.01.26.
//

import SwiftUI

struct OrganizationsSection: View {
    //MARK: - Properties
    let organisations: [OrganisationItemModel]
    let seeOrganizationList: () -> Void
    let seeOrganizationDetails: (_ OrganizationId: Int) -> Void

    //MARK: - Grid Layout
    let columns = Array(repeating: GridItem(.flexible(), spacing: 16), count: 3)

    //MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            sectionHeader
            organisationsSection
        }
    }
}

private extension OrganizationsSection {
    var sectionHeader: some View {
        HStack {
            Text("Organization Organizations")
                .font(.app(size: .lg, weight: .semibold))
                .foregroundColor(.colorGray900)
            Spacer()

            Button("See All") { seeOrganizationList() }
                .font(.app(size: .sm, weight: .semibold))
                .foregroundColor(.colorPrimary)
        }
        .padding(.horizontal)
    }

    var organisationsSection: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            ForEach(organisations) { organisation in
                OrganisationCard(
                    organisation: organisation,
                    seeOrganizationDetails: seeOrganizationDetails
                )
            }
        }
        .padding(.horizontal)
    }
}
