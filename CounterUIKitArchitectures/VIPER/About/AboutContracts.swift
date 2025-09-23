//
//  AboutContracts.swift
//  CounterUIKitArchitectures
//
//  Created by Andres Sanchez on 22/9/25.
//

protocol AboutViewOutput: AnyObject {
    func viewDidLoad()
}

protocol AboutViewInput: AnyObject {
    func render(text: String)
}

protocol AboutRouterInput: AnyObject {}
