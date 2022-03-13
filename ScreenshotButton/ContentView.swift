//
//  ContentView.swift
//  ScreenshotButton
//
//  Created by laptop on 3/7/22.
//

import SwiftUI

struct ContentView: View {
  @StateObject var colorSession = ColorMultipeerSession()

  @Binding var otter: String
  @Binding var path: String
  @Binding var prefix: String
  @Binding var hidden: Bool

  var body: some View {
    VStack {
      Text("Connected Devices:").bold()

      Text(String(describing: colorSession.connectedPeers.map(\.displayName)))

      TextField("Otter", text: $otter)
      TextField("File Path", text: $path)
      TextField("File Prefix", text: $prefix)

      Button("Screenshot") {
        // send(.hideAppForSeconds(.1))
        hidden = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
          TakeScreensShots(folderName: path, filePrefix: prefix)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
          hidden = false
        }

      }.disabled(true)

      Spacer()

    }
    .padding()
    .font(.largeTitle)

  }
}
