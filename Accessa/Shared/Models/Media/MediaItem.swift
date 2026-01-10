//
//  MediaItem.swift
//  Accessa
//
//  Created by Tatarella on 10.01.26.
//


struct MediaItem: Decodable, Identifiable {
    let id: Int
    let thumbnails: MediaThumbnails

    enum CodingKeys: String, CodingKey {
        case id = "media_id"
        case thumbnails
    }
}

extension MediaItem {
    var thumbnailSm: String {
        thumbnails.size180
    }
    
    var thumbnailLg: String {
        thumbnails.size445x420
    }
}


