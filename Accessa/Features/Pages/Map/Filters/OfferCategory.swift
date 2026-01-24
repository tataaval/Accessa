//
//  OfferCategory.swift
//  Accessa
//
//  Created by Tatarella on 24.01.26.
//


enum OfferCategory: String, CaseIterable, Identifiable, Codable {
    case goingOut = "going-out"
    case learning = "learning"
    case beautyHealth = "beauty-health"
    case sports = "sport"
    case foodDrinks = "food-drinks"
    case hotel = "hotel"
    case services = "services"
    case shopping = "shopping"
    case travelling = "travelling"

    var id: String { rawValue }

    var title: String {
        switch self {
        case .goingOut: return "Going out"
        case .learning: return "Learning"
        case .beautyHealth: return "Health & Beauty"
        case .sports: return "Sport"
        case .foodDrinks: return "Food & Drink"
        case .hotel: return "Hotels"
        case .services: return "Services"
        case .shopping: return "Shopping"
        case .travelling: return "Travelling"
        }
    }
}
