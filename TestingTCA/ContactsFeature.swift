//
//  ContactsFeature.swift
//  TestingTCA
//
//  Created by Giulia Stefainski on 15/04/26.
//

import Foundation
import ComposableArchitecture


struct Contact: Equatable, Identifiable {
  let id: UUID
  var name: String
}


@Reducer
struct ContactsFeature {
  @ObservableState
  struct State: Equatable {
    var contacts: IdentifiedArrayOf<Contact> = []
  }
  enum Action {
    case addButtonTapped
  }
  var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
      case .addButtonTapped:
        // TODO: Handle action
        return .none
      }
    }
  }
}
