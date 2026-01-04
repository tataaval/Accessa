//
//  LoginViewController.swift
//  Accessa
//
//  Created by Tatarella on 03.01.26.
//

import UIKit

final class LoginViewController: UIViewController {

    var onLoginSuccess: (() -> Void)?
    var onRegister: (() -> Void)?
    var onForgot: (() -> Void)?

    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        return button
    }()

    private let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Register", for: .normal)
        return button
    }()

    private let forgotButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Forgot password?", for: .normal)
        button.titleLabel?.font = .app(size: .base, weight: .semibold)
        button.tintColor = .colorPrimary
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Login"
        setupUI()
        setupActions()

    }

    private func setupUI() {
        let stackView = UIStackView(arrangedSubviews: [
            loginButton, registerButton, forgotButton,
        ])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 20

        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

    private func setupActions() {
        loginButton.addAction(
            UIAction { [weak self] _ in
                self?.onLoginSuccess?()
            },
            for: .touchUpInside
        )

        registerButton.addAction(
            UIAction { [weak self] _ in
                self?.onRegister?()
            },
            for: .touchUpInside
        )

        forgotButton.addAction(
            UIAction { [weak self] _ in
                self?.onForgot?()
            },
            for: .touchUpInside
        )
    }
}
