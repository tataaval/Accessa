//
//  TextInputItem.swift
//  Accessa
//
//  Created by Tatarella on 04.01.26.
//

import UIKit

final class TextInputItem: UIStackView {
    //MARK: - Computed Porperty
    var text: String {
        get {
            textField.text ?? ""
        }

        set {
            textField.text = newValue
        }
    }

    //MARK: - UI Components
    let inputLabel: UILabel = {
        let label = UILabel()
        label.font = .app(size: .sm, weight: .semibold)
        label.textColor = .colorGray500
        return label
    }()

    let textField: UITextField = {
        let textField = UITextField()
        textField.font = .app(size: .base)
        textField.textColor = .colorGray500
        textField.autocorrectionType = .no
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.colorGray300.cgColor
        textField.setLeftPadding(16)
        textField.heightAnchor.constraint(equalToConstant: 53).isActive = true
        return textField
    }()

    let errorLabel: UILabel = {
        let label = UILabel()
        label.font = .app(size: .xs)
        label.textColor = .colorError
        label.text = " "
        label.heightAnchor.constraint(equalToConstant: 16).isActive = true
        return label
    }()

    //MARK: - Initializers
    init(title: String, placeholder: String) {
        super.init(frame: .zero)
        inputLabel.text = title
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [
                .foregroundColor: UIColor.colorGray500,
                .font: UIFont.app(size: .sm),
            ]
        )

        setupUI()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Setup Methods
    private func setupUI() {
        axis = .vertical
        spacing = 6

        addArrangedSubview(inputLabel)
        addArrangedSubview(textField)
        addArrangedSubview(errorLabel)
    }

    //MARK: - Public Methods
    func setError(_ message: String?) {
        if let message = message {
            errorLabel.text = message
            textField.layer.borderColor = UIColor.colorError.cgColor
        } else {
            errorLabel.text = " "
            textField.layer.borderColor = UIColor.colorGray300.cgColor
        }
    }
}
