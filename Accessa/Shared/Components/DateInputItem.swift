//
//  DateInputItem.swift
//  Accessa
//
//  Created by Tatarella on 06.01.26.
//

import UIKit

final class DateInputItem: UIStackView {

    // MARK: - Computed Property
    var text: String {
        textField.text ?? ""
    }

    // MARK: - UI Components
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
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.colorGray300.cgColor
        textField.setLeftPadding(16)
        textField.heightAnchor.constraint(equalToConstant: 53).isActive = true
        textField.tintColor = .clear
        return textField
    }()

    private let calendarButton: UIButton = {
        let button = UIButton(type: .system)
        let config = UIImage.SymbolConfiguration(
            pointSize: 12,
            weight: .regular
        )
        button.setImage(
            UIImage(systemName: "calendar", withConfiguration: config),
            for: .normal
        )
        button.tintColor = .colorGray500
        return button
    }()

    let errorLabel: UILabel = {
        let label = UILabel()
        label.font = .app(size: .xs)
        label.textColor = .colorError
        label.text = " "
        label.heightAnchor.constraint(equalToConstant: 16).isActive = true
        return label
    }()

    private let datePicker = UIDatePicker()
    private let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        return formatter
    }()

    // MARK: - Init
    init(title: String, placeholder: String) {
        super.init(frame: .zero)
        inputLabel.text = title
        textField.placeholder = placeholder

        setupUI()
        setupDatePicker()
        setupActions()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup UI
    private func setupUI() {
        axis = .vertical
        spacing = 6

        addArrangedSubview(inputLabel)
        addArrangedSubview(textField)
        addArrangedSubview(errorLabel)

        setupCalendarButton()
    }

    private func setupCalendarButton() {
        calendarButton.frame = CGRect(x: 0, y: 0, width: 40, height: 53)

        let container = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 53))
        container.addSubview(calendarButton)
        calendarButton.center = container.center

        textField.rightView = container
        textField.rightViewMode = .always
    }

    private func setupDatePicker() {
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels

        textField.inputView = datePicker
        textField.inputAccessoryView = makeToolbar()
    }

    // MARK: - Actions
    private func setupActions() {
        calendarButton.addAction(
            UIAction { [weak self] _ in
                self?.textField.becomeFirstResponder()
            },
            for: .touchUpInside
        )
    }

    @objc private func doneTapped() {
        textField.text = formatter.string(from: datePicker.date)
        setError(nil)
        textField.resignFirstResponder()
    }

    @objc private func cancelTapped() {
        textField.resignFirstResponder()
    }

    // MARK: - Toolbar
    private func makeToolbar() -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()

        let cancel = UIBarButtonItem(
            title: "Cancel",
            style: .plain,
            target: self,
            action: #selector(cancelTapped)
        )

        let done = UIBarButtonItem(
            title: "Done",
            style: .prominent,
            target: self,
            action: #selector(doneTapped)
        )

        toolbar.items = [cancel, done]
        return toolbar
    }

    //MARK: - Public Methods
    func setError(_ message: String?) {
        if let message {
            errorLabel.text = message
            textField.layer.borderColor = UIColor.colorError.cgColor
        } else {
            errorLabel.text = " "
            textField.layer.borderColor = UIColor.colorGray300.cgColor
        }
    }
}
