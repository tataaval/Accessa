//
//  LoginViewController.swift
//  Accessa
//
//  Created by Tatarella on 03.01.26.
//

import UIKit

final class LoginViewController: UIViewController {

    //MARK: - Callbacks
    var onLoginSuccess: (() -> Void)?
    var onRegister: (() -> Void)?
    var onForgot: (() -> Void)?

    private var viewModel: LoginViewModelType

    //MARK: - UI Components
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Accessa"
        label.font = .app(size: .xl, weight: .bold)
        label.textColor = .colorPrimary
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign in to access your Accessa Card"
        label.font = .app(size: .base)
        label.textColor = .colorGray500
        label.numberOfLines = 0
        return label
    }()

    private let forgotButton = TextButton(title: "Forgot password?")
    private let formInputs = FormInputs()
    private let loginButton = PrimaryButton(title: "Login")

    private let footerContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4
        return stackView
    }()

    private let footerLabel: UILabel = {
        let label = UILabel()
        label.text = "Don't have an account?"
        label.font = .app(size: .base, weight: .semibold)
        label.textColor = .colorGray500
        return label
    }()

    private let registerButton = TextButton(title: "Create account")

    // MARK: - Init
    init(viewModel: LoginViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Lifesycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        setupBindings()
        setupActions()
    }

    //MARK: - Setup Methods
    private func setupUI() {
        setupFormFooterUI()
        setupFormStackUI()
    }

    private func setupFormFooterUI() {
        footerContainer.addArrangedSubview(footerLabel)
        footerContainer.addArrangedSubview(registerButton)
    }

    private func setupFormStackUI() {

        let stackView = UIStackView(arrangedSubviews: [
            titleLabel, descriptionLabel, formInputs, forgotButton,
            loginButton, footerContainer,
        ])

        forgotButton.contentHorizontalAlignment = .right

        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 10

        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 30
            ),
            stackView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 20
            ),
            stackView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -20
            ),

            loginButton.heightAnchor.constraint(equalToConstant: 54),

        ])
    }

    private func setupBindings() {
        viewModel.output = self
    }

    private func setupActions() {
        loginButton.addAction(
            UIAction { [weak self] _ in
                guard let self else { return }
                self.viewModel.input.login(
                    id: self.formInputs.idNumber.text,
                    password: self.formInputs.password.text
                )
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
    
    private func showError(_ message: String) {
       let alert = UIAlertController(title: "Login Failed", message: message, preferredStyle: .alert)
       alert.addAction(UIAlertAction(title: "OK", style: .default))
       present(alert, animated: true)
   }
}

extension LoginViewController: LoginViewModelOutput {
    func setLoading(_ isLoading: Bool) {
        loginButton.setLoading(isLoading)
    }
    
    func loginDidSucceed() {
        self.onLoginSuccess?()
    }

    func loginDidFail(error: String) {
        showError(error)
    }

    func onValidationError(errors: [String: String]) {
        formInputs.resetErrors()
        formInputs.setErrors(errors)
    }

}
