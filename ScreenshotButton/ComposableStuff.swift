//
//  ComposableStuff.swift
//  ScreenshotButton
//
//  Created by laptop on 3/12/22.
//

import ComposableArchitecture

struct AppState: Equatable {
  var otter =
    "If you're recording an Otter, paste it here. Eventually, I hope this can automatically detect if you're recording one of any publicly available voice to text transcriptions. And I hope the price of them goes down for all of those services, and will do everything in my power to maximize the uncomplicated individual's access to powerful organizational tools such as quality voice transcription with hot word custom mapping."
  var path = "/Users/laptop/Desktop/"
  var prefix = ""
  var syncState = SynchronizationState()
}
//
//enum SyncrhonizationAction: Equatable {
//  case syncStateReceived( /*TODO json or data handling*/String)
//  case sendSyncState( /*TODO json or data handling*/String)
//
//  /* going to right these as human readable as an experiement (see 95 commands otter recording */
//  case sayIdLikeToJoinYourSession/*(SyncrhonizationAction  ) *//*
//                                                                * Session ID will be in sender's state, so don't need to specify as argument
//                                                                */
//  case hearThatSomeoneWouldLikeToJoinYourSession(invitingPeerId: String)
//  case attemptToJoinSession(sessionId: String)
//  case joinSessionSuccesfully(
//    sessionId: String,
//    peers: [String],
//    /*TODO json or data handling instead of plain String*/
//    currentState: String
//  )
//}

enum AppAction: Equatable {
  // TODO -> can I move these to a single struct that's mutable with viewStore#binding?
  case otterTextChanged(String)
  case pathTextChanged(String)
  case prefixTextChanged(String)
  case synchronization(SynchronizationAction)
}

struct AppEnvironment {}

//let urlReducer = Reducer<AppState, AppAction, AppEnvironment> { state, action, environment in
//  switch action {
//
//  case let .otterTextChanged(otter):
//    state.otter = otter
//    return .none
//  case let .pathTextChanged(path):
//    state.path = path
//    return .none
//  case let .prefixTextChanged(prefix):
//    state.prefix = prefix
//    return .none
//
//
//  }
//}

//let appReducer = .


 let appReducer = Reducer<AppState, AppAction, AppEnvironment>.combine(
  
  synchronizationReducer.pullback(
    state: \AppState.syncState,
    action: /AppAction.synchronization,
    environment: { _ in
      SynchronizationEnvironment()
    }
  ),
  
  Reducer { state, action, environment in
    switch action {

    case let .otterTextChanged(otter):
      state.otter = otter
      return .none
    case let .pathTextChanged(path):
      state.path = path
      return .none
    case let .prefixTextChanged(prefix):
      state.prefix = prefix
      return .none
      
    case .synchronization(_):
      return .none
    }
  }
)
