//
//  CounterFeature.swift
//  TestingTCA
//
//  Created by Giulia Stefainski on 14/04/26.
//


import ComposableArchitecture
import Foundation

@Reducer
struct CounterFeature {
    @ObservableState
    struct State {
        var count = 0
        var fact: String?
        var isLoading = false
        var isTimerRunning: Bool = false
    }
    
    enum Action {
        case decrementButtonTapped
        case incrementButtonTapped
        case factButtonTapped
        case factResponse(String)
        case toggleTimerButtonTapped
        case timerTick
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .decrementButtonTapped:
                state.count -= 1
                state.fact = nil
                return .none
                
            case .incrementButtonTapped:
                state.count += 1
                state.fact = nil
                return .none
                
            case .factButtonTapped:
                state.fact = nil
                state.isLoading = true
                return .run { [count = state.count] send in
                    let (data, _) = try await URLSession.shared
                        .data(from: URL(string: "http://number-trivia.com/\(count)")!)
                    let fact = String(decoding: data, as: UTF8.self)
                    
                    await send(.factResponse(fact))
                }
            case .factResponse(let fact):
                state.fact = fact
                state.isLoading = false
                return .none
            case .toggleTimerButtonTapped:
                state.isTimerRunning.toggle()
                return .run { send in
                    while true {
                        try await Task.sleep(for: .seconds(1))
                        await send(.timerTick)
                    }
                }
            case .timerTick:
                state.count += 1
                state.fact = nil
                return .none
            }
        }
    }
}
