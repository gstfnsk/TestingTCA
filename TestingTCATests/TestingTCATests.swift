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
        
        let clock = TestClock()
        
        let store = TestStore(initialState: CounterFeature.State()) {
            CounterFeature()
        } withDependencies: {
            $0.continuousClock = clock
        }
        
        // Test timer running and stopping
        await store.send(.toggleTimerButtonTapped) {
            $0.isTimerRunning = true
        }
        await clock.advance(by: .seconds(1))
        await store.receive(\.timerTick) {
            $0.count = 1
        }
        await store.send(.toggleTimerButtonTapped) {
            $0.isTimerRunning = false
        }
        
        // Test +/- button actions
        await store.send(.incrementButtonTapped) {
            $0.count += 1
        }
        await store.send(.decrementButtonTapped) {
            $0.count -= 1
        }
    }
}
