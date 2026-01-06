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
        placeholder: "01010101011"
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

    func setErrors(_ errors: [String: String]) {
        if let e = errors["idNumber"] { idNumber.setError(e) }
        if let e = errors["password"] { password.setError(e) }
    }
}
