//
//  ForgotPasswordViewController.swift
//  Accessa
//
//  Created by Tatarella on 03.01.26.
//

import UIKit

final class ForgotPasswordViewController: UIViewController {
    //MARK: - Viewmodel
    private var viewModel: ForgotPasswordViewModelType

    //MARK: - UI Components
    private let formStack = UIStackView()

    private let lockImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "lock"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Forgot Password?"
        label.textAlignment = .center
        label.font = .app(size: .xl, weight: .bold)
        label.textColor = .colorPrimary
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text =
            "Don't worry! Enter your email and we'll send you a link to reset your password."
        label.textAlignment = .center
        label.font = .app(size: .base)
        label.textColor = .colorGray500
        label.numberOfLines = 0
        return label
    }()

    private let email = TextInputItem(
        title: "Email Address",
        placeholder: "your@email.com"
    )
    private let submitButton = PrimaryButton(title: "Send link")

    private lazy var successView = SuccessStateView(
        message: "We’ve sent a password reset link to your email."
    )

    // MARK: - Init
    init(viewModel: ForgotPasswordViewModelType) {
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
        setupFormStackUI()
        setupSuccessView()
    }

    private func setupFormStackUI() {
        formStack.addArrangedSubview(lockImageView)
        formStack.addArrangedSubview(titleLabel)
        formStack.addArrangedSubview(descriptionLabel)
        formStack.addArrangedSubview(email)
        formStack.addArrangedSubview(submitButton)

        formStack.axis = .vertical
        formStack.distribution = .fill
        formStack.spacing = 16

        view.addSubview(formStack)
        formStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            formStack.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 20
            ),
            formStack.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 20
            ),
            formStack.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -20
            ),

        ])
    }

    private func setupSuccessView() {
        view.addSubview(successView)
        successView.translatesAutoresizingMaskIntoConstraints = false
        successView.isHidden = true

        NSLayoutConstraint.activate([
            successView.topAnchor.constraint(equalTo: view.topAnchor),
            successView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            successView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            successView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    private func setupBindings() {
        viewModel.output = self
    }

    private func setupActions() {
        submitButton.addAction(
            UIAction { [weak self] _ in
                guard let self else { return }
                self.viewModel.input.sendInstructions(
                    email: email.text,
                )
            },
            for: .touchUpInside
        )
    }

    private func showError(_ message: String) {
        let alert = UIAlertController(
            title: "Error Occured",
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    private func transitionToSuccessState() {
        UIView.transition(
            from: formStack,
            to: successView,
            duration: 0.25,
            options: [.transitionCrossDissolve, .showHideTransitionViews]
        )
    }

}

extension ForgotPasswordViewController: ForgotPasswordViewModelOutput {
    func sendInstructionsDidComplete() {
        transitionToSuccessState()
    }

    func sendInstructionsDidFail(error: String) {
        showError(error)
    }

    func onValidationError(errors: [ForgotPasswordInputField: String]) {
        email.setError(nil)
        if let error = errors[.email] { email.setError(error) }
    }

    func setLoading(_ isLoading: Bool) {
        submitButton.setLoading(isLoading)
    }

}
