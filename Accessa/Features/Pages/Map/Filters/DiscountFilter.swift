//
//  DiscountFilter.swift
//  Accessa
//
//  Created by Tatarella on 24.01.26.
//


enum DiscountFilter: String, CaseIterable, Identifiable {
    case all = "All"
    case low = "10%+"
    case medium = "20%+"
    case high = "50%+"

    var id: String { rawValue }

    func matches(discount: Int) -> Bool {
        switch self {
        case .all: return true
        case .low: return discount >= 10
        case .medium: return discount >= 20
        case .high: return discount >= 50
        }
    }
}