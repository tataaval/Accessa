//
//  SuccessStateView.swift
//  Accessa
//
//  Created by Tatarella on 07.01.26.
//

import UIKit

final class SuccessStateView: UIView {

    // MARK: - UI Components
    private let iconImageView: UIImageView = {
        let imageView = UIImageView(
            image: UIImage(systemName: "checkmark.circle.fill")
        )
        imageView.tintColor = .colorSecondary
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let messageLabel: UILabel = {
        let label = UILabel()
        label.font = .app(size: .base, weight: .semibold)
        label.textColor = .colorPrimary
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    // MARK: - Init
    init(message: String) {
        super.init(frame: .zero)
        messageLabel.text = message
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup Method
    private func setupUI() {
        backgroundColor = .white

        let stack = UIStackView(arrangedSubviews: [
            iconImageView,
            messageLabel,
        ])
        stack.axis = .vertical
        stack.spacing = 16
        stack.alignment = .center

        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            iconImageView.heightAnchor.constraint(equalToConstant: 72),
            iconImageView.widthAnchor.constraint(equalToConstant: 72),

            stack.centerXAnchor.constraint(equalTo: centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: centerYAnchor),
            stack.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 50
            ),
            stack.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -50
            ),
        ])
    }
}
