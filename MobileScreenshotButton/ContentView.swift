//
//  ContentView.swift
//  ScreenshotButton
//
//  Created by laptop on 3/7/22.
//

import SwiftUI

struct ContentView: View {
  @StateObject var colorSession = ColorMultipeerSession()

  var body: some View {
    VStack {
      Text("Connected Devices:").bold()

      Text(String(describing: colorSession.connectedPeers.map(\.displayName)))

      Button("Trigger Desktop Screenshot") {
        colorSession.send(color: .green)
      }.disabled(colorSession.connectedPeers.isEmpty)

      Spacer()

    }
    .padding()
    .font(.largeTitle)

  }
}
