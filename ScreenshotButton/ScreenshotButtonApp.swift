//
//  ScreenshotButtonApp.swift
//  ScreenshotButton
//
//  Created by laptop on 3/7/22.
//

import ComposableArchitecture
import Foundation
import SwiftUI

struct AppState: Equatable {
  var otter =
    "If you're recording an Otter, paste it here. Eventually, I hope this can automatically detect if you're recording one of any publicly available voice to text transcriptions. And I hope the price of them goes down for all of those services, and will do everything in my power to maximize the uncomplicated individual's access to powerful organizational tools such as quality voice transcription with hot word custom mapping."
  var path = "/Users/laptop/Desktop/"
  var prefix = ""
}

enum AppAction: Equatable {
  case otterTextChanged(String)
  case pathTextChanged(String)
  case prefixTextChanged(String)
}

struct AppEnvironment {}

let appReducer = Reducer<AppState, AppAction, AppEnvironment> { state, action, environment in
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
  }
}

let DEFAULT_SIZE = 850.0
let HIDDEN_SIZE = 0.0

@main
struct ScreenshotButtonApp: App {

  @State var size = DEFAULT_SIZE

  func toggleAppVisibility(_ show: Bool) {
    size = show ? DEFAULT_SIZE : HIDDEN_SIZE
  }

  var body: some Scene {
    WindowGroup {
      ContentView(
        store: Store(
          initialState: AppState(),
          reducer: appReducer,
          environment: AppEnvironment()
        ),
        toggleAppVisibility: toggleAppVisibility
      )
      .frame(
        minWidth: size,
        maxWidth: size,
        idealHeight: size
      )
    }
  }
}
