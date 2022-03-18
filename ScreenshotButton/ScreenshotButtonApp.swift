//
//  ScreenshotButtonApp.swift
//  ScreenshotButton
//
//  Created by laptop on 3/7/22.
//

import ComposableArchitecture
import SwiftUI

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
