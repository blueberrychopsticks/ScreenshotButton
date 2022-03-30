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

  var body: some View {

    WithViewStore(store) { viewStore in

      VStack {
        Text("Discovered Peers").bold()
        Text(String(describing: viewStore.syncState.session.peers.map(\.displayName)))

        Text("State").bold()
        Text(String(describing: viewStore.syncState.session.status))
//        TextField(
//          "Otter",
//          text: viewStore.binding(
//            get: \.otter,
//            send: AppAction.otterTextChanged
//          )
//        )
//
//        TextField(
//          "File Path",
//          text: viewStore.binding(
//            get: \.path,
//            send: AppAction.pathTextChanged
//          )
//        )
//
//        TextField(
//          "File Prefix",
//          text: viewStore.binding(
//            get: \.prefix,
//            send: AppAction.prefixTextChanged
//          )
//        )
//
//        Button("Screenshot") {
//          // send(.hideAppForSeconds(.1))
//          toggleAppVisibility(false)
//
//          DispatchQueue.main.asyncAfter(deadline: .now()) {
//            TakeScreensShots(folderName: viewStore.path, filePrefix: viewStore.prefix)
//          }
//
//          DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
//            toggleAppVisibility(true)
//          }
//
//        }

        Spacer()

      }
      .padding()
      .font(.largeTitle)
      .onAppear {
        viewStore.send(.synchronization(.startBrowsing))
        viewStore.send(.synchronization(.startBroadcasting))
      }

    }
  }
}
