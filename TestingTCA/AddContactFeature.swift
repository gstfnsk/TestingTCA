//
//  AddContactFeature.swift
//  TestingTCA
//
//  Created by Giulia Stefainski on 15/04/26.
//

import Foundation
import ComposableArchitecture

@Reducer
struct AddContactFeature {
  @ObservableState
  struct State: Equatable {
    var contact: Contact
  }
  enum Action {
    case cancelButtonTapped
    case saveButtonTapped
    case setName(String)
  }
  var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
      case .cancelButtonTapped:
        return .none
        
      case .saveButtonTapped:
        return .none
        
      case let .setName(name):
        state.contact.name = name
        return .none
      }
    }
  }
}
