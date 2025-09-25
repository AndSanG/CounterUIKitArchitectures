//
//  CounterStore.swift
//  CounterUIKitArchitectures
//
//  Created by Andres Sanchez on 25/9/25.
//

import Foundation
import Combine

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

// combine implementation
final class CombineStore<State, Action>: ObservableObject {
    // Published so SwiftUI / Combine consumers can observe.
    @Published private(set) var state: State

    private let reducer: Reducer<State, Action>

    init(initial: State, reducer: @escaping Reducer<State, Action>) {
        self.state = initial
        self.reducer = reducer
    }

    /// Synchronously dispatch an action (must be called on main).
    func dispatch(_ action: Action) {
        precondition(Thread.isMainThread, "Dispatch must occur on the main thread.")
        reducer(&state, action)
    }

    /// Return a Combine publisher for the state (erased).
    func publisher() -> AnyPublisher<State, Never> {
        return $state.eraseToAnyPublisher()
    }

    /// Convenience subscribe method that immediately emits the current state,
    /// then forwards updates. Caller must keep the returned AnyCancellable alive
    /// to remain subscribed.
    @discardableResult
    func subscribe(_ sink: @escaping (State) -> Void) -> AnyCancellable {
        // Emit current state immediately (matches previous behavior).
        sink(state)

        // Subscribe to future changes. Use receive(on:) to ensure delivery on main.
        let cancellable = $state
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: sink)

        return cancellable
    }
}
