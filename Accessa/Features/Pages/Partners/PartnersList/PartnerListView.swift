//
//  PartnerListView.swift
//  Accessa
//
//  Created by Tatarella on 03.01.26.
//

import SwiftUI

struct PartnerListView: View {
    let router: HomeRouter
    
    var body: some View {
        VStack {
            Button("Partner 1") {
                router.openOrganization(id: 1)
            }
        }
        .navigationTitle("Partners")
    }
}
