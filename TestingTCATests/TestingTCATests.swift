//
//  TestingTCATests.swift
//  TestingTCATests
//
//  Created by Giulia Stefainski on 14/04/26.
//

import Testing
import ComposableArchitecture

@testable import TestingTCA

@MainActor
struct TestingTCATests {

    @Test
    
    func basics() async {
        let store = TestStore(initialState: CounterFeature.State()) {
            CounterFeature()
        }
        await store.send(.incrementButtonTapped) {
            $0.count = 1
        }
        await store.send(.decrementButtonTapped) {
            $0.count = 0
        }
        
        await store.send(.toggleTimerButtonTapped) {
              $0.isTimerRunning = true
        }
        await store.send(.toggleTimerButtonTapped) {
              $0.isTimerRunning = false
        }
    }
}
