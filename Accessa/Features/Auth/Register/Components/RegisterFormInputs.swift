//
//  RegisterFormInputs.swift
//  Accessa
//
//  Created by Tatarella on 06.01.26.
//

import UIKit

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

    func setErrors(_ errors: [RegistrationInputField: String]) {
        if let error = errors[.name] { name.setError(error) }
        if let error = errors[.idNumber] { idNumber.setError(error) }
        if let error = errors[.phone] { phone.setError(error) }
        if let error = errors[.birthDate] { birthDate.setError(error) }
        if let error = errors[.email] { email.setError(error) }
        if let error = errors[.password] { password.setError(error) }
        if let error = errors[.repeatPassword] { repeatPassword.setError(error) }
    }
}
