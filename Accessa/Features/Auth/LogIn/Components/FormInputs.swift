//
//  FormInputs.swift
//  Accessa
//
//  Created by Tatarella on 05.01.26.
//

import UIKit

final class FormInputs: UIStackView {

    // MARK: - UI Components
    let idNumber = TextInputItem(
        title: "ID Number",
        placeholder: "01010101011",
        type: .numeric
    )
    let password = PasswordInputItem(
        title: "Password",
        placeholder: "Enter Your Password"
    )

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        axis = .vertical
        spacing = 8

        addArrangedSubview(idNumber)
        addArrangedSubview(password)
    }

    required init(coder: NSCoder) { fatalError() }

    // MARK: - Validation Helpers
    func resetErrors() {
        idNumber.setError(nil)
        password.setError(nil)
    }

    func setErrors(_ errors: [LoginInputField: String]) {
        if let error = errors[.idNumber] { idNumber.setError(error) }
        if let error = errors[.password] { password.setError(error) }
    }
}
