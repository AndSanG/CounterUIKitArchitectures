//
//  CounterView.swift
//  CounterUIKitArchitectures
//
//  Created by Andres Sanchez on 25/9/25.
//

import UIKit

final class RxCounterViewController: UIViewController {
    private let store: Store<CounterState, CounterAction>!
    private var subscription: AnyObject?
    
    private let counterView = CounterView()
    private let resetButton = UIButton(type: .system)
    private let aboutButton = UIButton(type: .system)

    
    init(store: Store<CounterState, CounterAction>) {
        self.store = store
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Redux"
        view.backgroundColor = .systemBackground
        

        counterView.buttonTitle = "Increment"
        resetButton.setTitle("Reset", for: .normal)

        counterView.action = { [weak self] in self?.increment()}
        resetButton.addTarget(self, action: #selector(reset), for: .touchUpInside)

        let stack = UIStackView(arrangedSubviews: [counterView, resetButton, aboutButton])
        stack.axis = .vertical
        stack.spacing = 16
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
        ])

        // Subscribe to state updates
        subscription = store.subscribe { [weak self] state in
            self?.counterView.text = "\(state.reduxFormatted)"
        }
    }
    // Action triger
    @objc private func increment() { store.dispatch(.increment) }
    @objc private func decrement() { store.dispatch(.decrement) }
    @objc private func reset()     { store.dispatch(.reset) }

}
