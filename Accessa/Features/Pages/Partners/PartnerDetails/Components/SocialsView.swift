//
//  SocialsView.swift
//  Accessa
//
//  Created by Tatarella on 13.01.26.
//

import SwiftUI

struct SocialsView: View {
    //MARK: - properties
    let companyURL: String?
    let tiktokURL: String?
    let instagramURL: String?
    let facebookURL: String?

    //MARK: - Body
    var body: some View {
        HStack(spacing: 12) {
            if let companyURL {
                SocialsLinkButton(
                    icon: "global",
                    title: "Website",
                    url: companyURL
                )
            }
            if let tiktokURL {
                SocialsLinkButton(
                    icon: "tiktok",
                    title: "Tiktok",
                    url: tiktokURL
                )
            }
            if let instagramURL {
                SocialsLinkButton(
                    icon: "instagram",
                    title: "Instagram",
                    url: instagramURL
                )
            }
            if let facebookURL {
                SocialsLinkButton(
                    icon: "facebook",
                    title: "Facebook",
                    url: facebookURL
                )
            }
        }
        .padding(.horizontal)
    }
}
