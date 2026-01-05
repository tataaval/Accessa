//
//  PrimaryButton.swift
//  Accessa
//
//  Created by Tatarella on 05.01.26.
//


import UIKit

final class PrimaryButton: UIButton {

    init(title: String) {
        super.init(frame: .zero)
        configure(title: title)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure(title: String) {
        setTitle(title, for: .normal)
        titleLabel?.font = .app(size: .lg)
        setTitleColor(.white, for: .normal)
        backgroundColor = .colorPrimary
        layer.cornerRadius = 14

        heightAnchor.constraint(equalToConstant: 54).isActive = true
    }

    func setLoading(_ isLoading: Bool) {
        isEnabled = !isLoading
        alpha = isLoading ? 0.5 : 1.0
    }
}
