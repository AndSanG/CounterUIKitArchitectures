//
//  CounterStore.swift
//  CounterUIKitArchitectures
//
//  Created by Andres Sanchez on 25/9/25.
//

import Foundation

final class Store<State, Action> {
    private(set) var state: State { didSet { subscribers.values.forEach { $0(state) } } }
    private let reducer: Reducer<State, Action>
    private var subscribers: [UUID: (State) -> Void] = [:]

    init(initial: State, reducer: @escaping Reducer<State, Action>) {
        self.state = initial
        self.reducer = reducer
    }

    func dispatch(_ action: Action) {
        precondition(Thread.isMainThread, "Dispatch must occur on the main thread.")
        reducer(&state, action)
    }

    @discardableResult
    func subscribe(_ sink: @escaping (State) -> Void) -> AnyObject {
        let id = UUID()
        subscribers[id] = sink
        sink(state) // emit current state immediately
        return Subscription { [weak self] in self?.subscribers[id] = nil }
    }

    private final class Subscription {
        private let cancel: () -> Void
        init(_ cancel: @escaping () -> Void) { self.cancel = cancel }
        deinit { cancel() }
    }
}
