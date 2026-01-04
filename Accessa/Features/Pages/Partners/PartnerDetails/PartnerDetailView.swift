//
//  PartnerDetailView.swift
//  Accessa
//
//  Created by Tatarella on 03.01.26.
//

import SwiftUI

struct PartnerDetailView: View {
    let id: Int
    
    var body: some View {
        Text("Partner \(id)")
            .navigationTitle("Partner Detail")
    }
}
