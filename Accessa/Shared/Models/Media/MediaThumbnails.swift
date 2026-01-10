//
//  MediaThumbnails.swift
//  Accessa
//
//  Created by Tatarella on 10.01.26.
//


struct MediaThumbnails: Decodable {
    let size180: String
    let size445x420: String

    enum CodingKeys: String, CodingKey {
        case size180 = "180x180"
        case size445x420 = "445x420"
    }
}