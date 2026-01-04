//
//  OfferDetailView.swift
//  Accessa
//
//  Created by Tatarella on 03.01.26.
//

import SwiftUI

struct OfferDetailView: View {
    let id: Int
    
    var body: some View {
        Text("Offer \(id)")
            .navigationTitle("Offer Detail")
    }
}
