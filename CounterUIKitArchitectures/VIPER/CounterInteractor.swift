//
//  CounterInteractor.swift
//  CounterUIKitArchitectures
//
//  Created by Andres Sanchez on 22/9/25.
//

final class CounterInteractor: CounterInteractorInput {
    weak var output: CounterInteractorOutput?

    private var counter = Counter(value: 0)

    func loadInitial() {
        output?.didLoadCurrentCount(counter.value)
    }

    func increment() {
        counter.value += 1
        output?.didUpdateCount(counter.value)
    }

    func reset() {
        counter.value = 0
        output?.didUpdateCount(counter.value)
    }
}
