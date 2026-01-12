//
//  OrganizationDetailModel.swift
//  Accessa
//
//  Created by Tatarella on 12.01.26.
//


struct OrganizationDetailModel: Decodable {
    let itemID: Int
    let title: String
    let cover: Media?
    let desc: String?
    let descriptionHTML: String?
    let companyURL: String?
    let mobile: String?
    let workingTime: String?
    let email: String
    let tiktokURL: String?
    let instagramURL: String?
    let facebookURL: String?
    let address: String
    let organisation: OrganizationInfo

    enum CodingKeys: String, CodingKey {
        case itemID = "item_id"
        case title
        case cover
        case desc
        case descriptionHTML = "text"
        case companyURL = "company_url"
        case mobile
        case workingTime = "working_time"
        case email
        case tiktokURL = "tiktok_url"
        case instagramURL = "instagram_url"
        case facebookURL = "facebook_url"
        case address
        case organisation
    }
}

extension OrganizationDetailModel {
    
    var coverImage: String? {
        cover?.url
    }
    
    var logoImage: String? {
        organisation.image?.url
    }
    
    var city: String {
        organisation.city
    }
}


