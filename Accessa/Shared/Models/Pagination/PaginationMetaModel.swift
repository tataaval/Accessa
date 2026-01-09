//
//  PaginationMetaModel.swift
//  Accessa
//
//  Created by Tatarella on 09.01.26.
//


struct PaginationMetaModel: Codable {
    let currentPage: Int
    let lastPage: Int
    let perPage: Int
    let total: Int

    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case lastPage = "last_page"
        case perPage = "per_page"
        case total
    }

    var hasNextPage: Bool {
        currentPage < lastPage
    }
}
