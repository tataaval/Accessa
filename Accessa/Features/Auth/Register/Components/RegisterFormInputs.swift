//
//  RegisterFormInputs.swift
//  Accessa
//
//  Created by Tatarella on 06.01.26.
//

import UIKit

enum RegistrationField: String {
    case name, idNumber, phone, birthDate, email, password, repeatPassword
}

final class RegisterFormInputs: UIStackView {

    // MARK: - UI Components
    let name = TextInputItem(
        title: "Name",
        placeholder: "Enter your first name"
    )

    let idNumber = TextInputItem(
        title: "ID Number",
        placeholder: "Enter your ID Number",
        type: .numeric
    )

    let phone = TextInputItem(
        title: "Phone",
        placeholder: "Enter your Phone Number",
        type: .numeric
    )

    let birthDate = DateInputItem(
        title: "Date of Birth",
        placeholder: "-/-/-"
    )

    let email = TextInputItem(
        title: "Email",
        placeholder: "your@email.com",
        type: .email
    )

    let password = PasswordInputItem(
        title: "Password",
        placeholder: "At least 8 characters"
    )

    let repeatPassword = PasswordInputItem(
        title: "Confirm Password",
        placeholder: "Re-enter your password"
    )

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        axis = .vertical
        spacing = 8

        addArrangedSubview(name)
        addArrangedSubview(idNumber)
        addArrangedSubview(phone)
        addArrangedSubview(birthDate)
        addArrangedSubview(email)
        addArrangedSubview(password)
        addArrangedSubview(repeatPassword)
    }

    required init(coder: NSCoder) { fatalError() }

    // MARK: - Validation Helpers
    func resetErrors() {
        name.setError(nil)
        idNumber.setError(nil)
        phone.setError(nil)
        birthDate.setError(nil)
        email.setError(nil)
        password.setError(nil)
        repeatPassword.setError(nil)
    }

    func setErrors(_ errors: [String: String]) {
        errors.forEach { key, message in
            switch key {
            case RegistrationField.name.rawValue:
                self.name.setError(message)
            case RegistrationField.idNumber.rawValue:
                self.idNumber.setError(message)
            case RegistrationField.phone.rawValue:
                self.phone.setError(message)
            case RegistrationField.birthDate.rawValue:
                self.birthDate.setError(message)
            case RegistrationField.email.rawValue:
                self.email.setError(message)
            case RegistrationField.password.rawValue:
                self.password.setError(message)
            case RegistrationField.repeatPassword.rawValue:
                self.repeatPassword.setError(message)
            default:
                break
            }
        }
    }
}
