//
//  CounterView.swift
//  CounterUIKitArchitectures
//
//  Created by Andres Sanchez on 19/9/25.
//

import UIKit

final class CounterView: UIView {
    // exposes texts and actions
    var action: (() -> Void)?
    var text: String? {
        didSet { updateLabelText(with: text) }
    }
    var buttonTitle: String? {
        didSet { updateButtonTitle(with: buttonTitle) }
    }
    
    // private implementation of the view
    private let label = UILabel()
    private let button = UIButton(type: .system)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        updateLabelText(with: text)
        label.textAlignment = .center
        button.setTitle(buttonTitle, for: .normal)
        button.addTarget(self, action: #selector(handleIncrementTap), for: .touchUpInside)

        let stack = UIStackView(arrangedSubviews: [label, button])
        stack.axis = .vertical
        stack.spacing = 12
        stack.alignment = .center

        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    // handle user action
    @objc private func handleIncrementTap() {
        action?()
    }
    
    private func updateLabelText(with text: String?) {
        guard Thread.isMainThread else {
            DispatchQueue.main.async { [weak self] in
                self?.updateLabelText(with: text)
            }
            return
        }
        label.text = text
    }
    
    private func updateButtonTitle(with title: String?) {
        guard Thread.isMainThread else {
            DispatchQueue.main.async { [weak self] in
                self?.updateButtonTitle(with: title)
            }
            return
        }
        button.setTitle(title, for: .normal)
    }
    // only
}
