//
//  AppConfig.swift
//  Accessa
//
//  Created by Tatarella on 17.01.26.
//


import Foundation

enum AppConfig {
    static var baseURL: URL {
        guard
            let value = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String,
            let url = URL(string: value)
        else {
            fatalError("BASE_URL is missing or invalid.")
        }
        return url
    }
}
