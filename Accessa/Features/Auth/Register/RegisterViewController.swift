//
//  RegisterViewController.swift
//  Accessa
//
//  Created by Tatarella on 03.01.26.
//

import UIKit

final class RegisterViewController: UIViewController {

    //MARK: - Viewmodel
    private var viewModel: RegisterViewModelType

    //MARK: - UI Components
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let formStack = UIStackView()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Register"
        label.font = .app(size: .xl, weight: .bold)
        label.textColor = .colorPrimary
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Fill the form to create your Accessa account."
        label.font = .app(size: .base)
        label.textColor = .colorGray500
        label.numberOfLines = 0
        return label
    }()

    private let registerForm = RegisterFormInputs()
    private let registerButton = PrimaryButton(title: "Create Account")
    private lazy var successView = SuccessStateView(
        message: "Registration was successful. You can log in now."
    )

    // MARK: - Init
    init(viewModel: RegisterViewModelType) {
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
        setupScrollViewUI()
        setupContentViewUI()
        setupFormStackUI()
        setupSuccessView()
    }

    private func setupScrollViewUI() {
        scrollView.alwaysBounceVertical = true
        scrollView.keyboardDismissMode = .interactive

        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    private func setupContentViewUI() {
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.topAnchor
            ),
            contentView.leadingAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.leadingAnchor
            ),
            contentView.trailingAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.trailingAnchor
            ),
            contentView.bottomAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.bottomAnchor
            ),

            contentView.widthAnchor.constraint(
                equalTo: scrollView.frameLayoutGuide.widthAnchor
            ),
        ])
    }

    private func setupFormStackUI() {
        formStack.addArrangedSubview(titleLabel)
        formStack.addArrangedSubview(descriptionLabel)
        formStack.addArrangedSubview(registerForm)
        formStack.addArrangedSubview(registerButton)

        formStack.axis = .vertical
        formStack.distribution = .fill
        formStack.spacing = 10

        contentView.addSubview(formStack)
        formStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            formStack.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 20
            ),
            formStack.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 20
            ),
            formStack.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -20
            ),
            formStack.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -20
            ),

        ])
    }

    private func setupSuccessView() {
        contentView.addSubview(successView)
        successView.translatesAutoresizingMaskIntoConstraints = false
        successView.isHidden = true

        NSLayoutConstraint.activate([
            successView.topAnchor.constraint(equalTo: contentView.topAnchor),
            successView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor
            ),
            successView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor
            ),
            successView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor
            ),
        ])
    }

    private func setupBindings() {
        viewModel.output = self
    }

    private func setupActions() {
        registerButton.addAction(
            UIAction { [weak self] _ in
                guard let self else { return }
                self.viewModel.input.register(
                    name: self.registerForm.name.text,
                    IdNumber: self.registerForm.idNumber.text,
                    phone: self.registerForm.phone.text,
                    birthDate: self.registerForm.birthDate.text,
                    email: self.registerForm.email.text,
                    password: self.registerForm.password.text,
                    repeatPassword: self.registerForm.repeatPassword.text
                )
            },
            for: .touchUpInside
        )
    }

    private func showError(_ message: String) {
        let alert = UIAlertController(
            title: "Registration Failed",
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    private func transitionToSuccessState() {
        scrollView.isScrollEnabled = false
        scrollView.showsVerticalScrollIndicator = false
        
        successView.isHidden = false
        successView.alpha = 0

        UIView.animate(withDuration: 0.25) {
            self.formStack.alpha = 0
            self.successView.alpha = 1
        }

        self.formStack.isHidden = true
    }

}

extension RegisterViewController: RegisterViewModelOutput {
    func registerDidSucceed() {
        registerForm.resetErrors()
        transitionToSuccessState()
    }

    func registerDidFail(error: String) {
        showError(error)
    }

    func onValidationError(errors: [String: String]) {
        registerForm.resetErrors()
        registerForm.setErrors(errors)
    }

    func setLoading(_ isLoading: Bool) {
        registerButton.setLoading(isLoading)
    }

}
