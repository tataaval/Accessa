//
//  PrimaryButton.swift
//  Accessa
//
//  Created by Tatarella on 05.01.26.
//

import UIKit

final class PrimaryButton: UIButton {
    //MARK: - Property
    private var buttonText: String?

    //MARK: - UI Component
    private let activityIndicator = UIActivityIndicatorView(style: .medium)

    //MARK: - Init
    init(title: String) {
        super.init(frame: .zero)
        configure(title: title)
        setupIndicator()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - setup functions
    private func configure(title: String) {
        setTitle(title, for: .normal)
        titleLabel?.font = .app(size: .lg, weight: .semibold)
        setTitleColor(.white, for: .normal)
        backgroundColor = .colorPrimary
        layer.cornerRadius = 14

        heightAnchor.constraint(equalToConstant: 54).isActive = true
    }

    private func setupIndicator() {
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .white
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }

    //MARK: - Public Method
    func setLoading(_ isLoading: Bool) {
        if isLoading {
            buttonText = title(for: .normal)
            setTitle("", for: .normal)
            activityIndicator.startAnimating()
        } else {
            setTitle(buttonText, for: .normal)
            activityIndicator.stopAnimating()
        }

        isEnabled = !isLoading
        alpha = isLoading ? 0.7 : 1.0
    }
}
