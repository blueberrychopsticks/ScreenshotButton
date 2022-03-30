import SwiftUI
import Foundation
import ComposableArchitecture

@main
struct MobileScreenshotButtonApp: App {

  @State var hidden = false
  var body: some Scene {
   
    WindowGroup {
      ContentView(
        store: Store(
          initialState: AppState(),
          reducer: appReducer,
          environment: AppEnvironment()
        ),
        toggleAppVisibility: { _ in }
      )
    }
  }
}
