//
//  ValidationService.swift
//  Accessa
//
//  Created by Tatarella on 04.01.26.
//

import Foundation

enum ValidationError: LocalizedError {
    case empty
    case invalidEmail
    case shortPassword
    case passwordsDontMatch
    case invalidIdNumber

    var errorDescription: String? {
        switch self {
        case .empty:
            return "This field is required"
        case .invalidEmail:
            return "Invalid email address"
        case .shortPassword:
            return "Password must be at least 8 characters"
        case .passwordsDontMatch:
            return "Passwords do not match"
        case .invalidIdNumber:
            return "ID number must contain exactly 11 digits"
        }
    }
}


protocol ValidationServiceProtocol {
    func validateIdNumber(_ text: String) -> ValidationError?
    func validateFullName(_ text: String) -> ValidationError?
    func validateEmail(_ text: String) -> ValidationError?
    func validatePassword(_ text: String) -> ValidationError?
    func validateRepeatPassword(_ text: String, password: String) -> ValidationError?
}


final class ValidationService: ValidationServiceProtocol {

    func validateIdNumber(_ text: String) -> ValidationError? {
        if text.isEmptyOrWhitespace {
            return .empty
        }

        let digitsOnly = text.allSatisfy(\.isNumber)
        if !digitsOnly || text.count != 11 {
            return .invalidIdNumber
        }

        return nil
    }

    func validateFullName(_ text: String) -> ValidationError? {
        if text.isEmptyOrWhitespace {
            return .empty
        }

        return nil
    }

    func validateEmail(_ text: String) -> ValidationError? {
        if text.isEmptyOrWhitespace {
            return .empty
        }

        if !text.isValidEmail {
            return .invalidEmail
        }

        return nil
    }

    func validatePassword(_ text: String) -> ValidationError? {
        if text.isEmptyOrWhitespace {
            return .empty
        }

        if !text.hasMinimumLength(8) {
            return .shortPassword
        }

        return nil
    }

    func validateRepeatPassword(_ text: String, password: String) -> ValidationError? {
        if text.isEmptyOrWhitespace {
            return .empty
        }

        if !text.hasMinimumLength(8) {
            return .shortPassword
        }

        if text != password {
            return .passwordsDontMatch
        }

        return nil
    }
}
