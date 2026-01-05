//
//  TextButton.swift
//  Accessa
//
//  Created by Tatarella on 05.01.26.
//


import UIKit

final class TextButton: UIButton {

    init(title: String, color: UIColor = .colorPrimary) {
        super.init(frame: .zero)
        configure(title: title, color: color)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure(title: String, color: UIColor) {
        setTitle(title, for: .normal)
        setTitleColor(color, for: .normal)
        titleLabel?.font = .app(size: .base, weight: .semibold)
        backgroundColor = .clear
    }
}
