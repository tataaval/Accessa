//
//  Organisation.swift
//  Accessa
//
//  Created by Tatarella on 10.01.26.
//

struct Organisation: Decodable {
    let pageURL: String?
    let title: String
    let image: Media?
    let city: String
    let tiktokURL: String?
    let instagramURL: String?
    let facebookURL: String?

    enum CodingKeys: String, CodingKey {
        case pageURL = "page_url"
        case title
        case image
        case city
        case tiktokURL = "tiktok_url"
        case instagramURL = "instagram_url"
        case facebookURL = "facebook_url"
    }
}
