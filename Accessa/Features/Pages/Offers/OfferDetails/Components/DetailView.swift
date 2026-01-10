//
//  DetailView.swift
//  Accessa
//
//  Created by Tatarella on 10.01.26.
//

import SwiftUI

struct DetailView: View {
    //MARK: - Properties
    let title: String
    let organization: String
    let endDate: String
    let location: String

    //MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            timeAndLocation
            titleAndOrganization
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

private extension DetailView {
    var timeAndLocation: some View {
        VStack(alignment: .leading, spacing: 10) {
            Label(endDate, systemImage: "clock")
                .font(.app(size: .sm, weight: .bold))
                .foregroundStyle(.colorSecondary)
            Label(location, systemImage: "location")
                .font(.app(size: .sm, weight: .bold))
                .foregroundStyle(.colorSecondary)
        }
    }
    
    var titleAndOrganization: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.app(size: .xl, weight: .bold))
                .foregroundStyle(.colorGray900)
            Text(organization)
                .font(.app(size: .base))
                .foregroundStyle(.colorGray500)
        }
    }
}
