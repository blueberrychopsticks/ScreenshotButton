//
//  ContentView.swift
//  ScreenshotButton
//
//  Created by laptop on 3/7/22.
//

import ComposableArchitecture
import SwiftUI

struct ContentView: View {
  let store: Store<AppState, AppAction>
  let toggleAppVisibility: (Bool) -> Void

  @StateObject var colorSession = ColorMultipeerSession()

  var body: some View {

    WithViewStore(store) { viewStore in

      VStack {
        Text("Connected Devices:").bold()

        Text(String(describing: colorSession.connectedPeers.map(\.displayName)))

        TextField(
          "Otter",
          text: viewStore.binding(
            get: \.otter,
            send: AppAction.otterTextChanged
          )
        )

        TextField(
          "File Path",
          text: viewStore.binding(
            get: \.path,
            send: AppAction.pathTextChanged
          )
        )

        TextField(
          "File Prefix",
          text: viewStore.binding(
            get: \.prefix,
            send: AppAction.prefixTextChanged
          )
        )

        Button("Screenshot") {
          // send(.hideAppForSeconds(.1))
          toggleAppVisibility(false)

          DispatchQueue.main.asyncAfter(deadline: .now()) {
            //            TakeScreensShots(folderName: path, filePrefix: prefix)
          }

          DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            toggleAppVisibility(true)
          }

        }

        Spacer()

      }
      .padding()
      .font(.largeTitle)

    }
  }
}
