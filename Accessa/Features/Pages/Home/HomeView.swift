//
//  HomeView.swift
//  Accessa
//
//  Created by Tatarella on 03.01.26.
//


import SwiftUI

struct HomeView: View {
    let router: HomeRouter

    var body: some View {
        VStack {
            Text("Roboto font")
                .font(.app(size: .lg, weight: .semibold))
            Button("Open Offer") {
                router.openOffer(id: 1)
            }
            Button("Open Partner") {
                router.openPartner(id: 1)
            }
            Button("Partners") {
                router.openPartners()
            }
        }
        .navigationTitle("Home")
    }
}
