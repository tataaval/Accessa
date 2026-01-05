//
//  SessionService.swift
//  Accessa
//
//  Created by Tatarella on 05.01.26.
//

import Foundation
import Security

protocol SessionServiceProtocol {
    func saveToken(_ token: String) throws
    func clearSession() throws
    var token: String? { get }
}

final class SessionService: SessionServiceProtocol {

    private enum Keys {
        static let authToken = "auth_token"
    }

    func saveToken(_ token: String) throws {
        let data = Data(token.utf8)

        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: Keys.authToken,
            kSecValueData: data,
            kSecAttrAccessible: kSecAttrAccessibleAfterFirstUnlock,
        ]

        SecItemDelete(query as CFDictionary)

        let status = SecItemAdd(query as CFDictionary, nil)
        guard status == errSecSuccess else {
            throw NSError(domain: "KeychainError", code: Int(status))
        }
    }

    func clearSession() throws {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: Keys.authToken,
        ]

        SecItemDelete(query as CFDictionary)
    }

    var token: String? {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: Keys.authToken,
            kSecReturnData: true,
            kSecMatchLimit: kSecMatchLimitOne,
        ]

        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)

        guard status == errSecSuccess,
            let data = item as? Data,
            let token = String(data: data, encoding: .utf8)
        else {
            return nil
        }

        return token
    }
}
