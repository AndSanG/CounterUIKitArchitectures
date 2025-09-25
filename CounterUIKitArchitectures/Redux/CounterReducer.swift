//
//  CounterReducer.swift
//  CounterUIKitArchitectures
//
//  Created by Andres Sanchez on 25/9/25.
//
import Foundation

typealias Reducer<State, Action> = (inout State, Action) -> Void

let counterReducer: Reducer<CounterState, CounterAction> = { state, action in
    switch action {
    case .increment: state.value += 1
    case .decrement: state.value -= 1
    case .reset:     state.value = 0
    }
}
