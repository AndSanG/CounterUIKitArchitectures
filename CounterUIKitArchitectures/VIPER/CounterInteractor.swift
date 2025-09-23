//
//  CounterInteractor.swift
//  CounterUIKitArchitectures
//
//  Created by Andres Sanchez on 22/9/25.
//

final class CounterInteractor: CounterInteractorInput {
    weak var output: CounterInteractorOutput?
    
    private let initialCount: Int
    private var counter: Counter
    
    init(initialCount: Int = 0){
        self.initialCount = initialCount
        counter = Counter(value: initialCount)
    }

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
