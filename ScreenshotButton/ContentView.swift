//
//  ContentView.swift
//  ScreenshotButton
//
//  Created by laptop on 3/7/22.
//

import SwiftUI

struct ContentView: View {
  @Binding var otter: String
  @Binding var path: String
  @Binding var prefix: String
  @Binding var hidden: Bool

  var body: some View {
    VStack {

      TextField("Otter", text: $otter)
      TextField("File Path", text: $path)
      TextField("File Prefix", text: $prefix)
      Button("Screenshot") {
        hidden = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
          TakeScreensShots(folderName: path, filePrefix: prefix)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
          hidden = false
        }

      }
      Spacer()
    }
    .padding()
    .font(.largeTitle)

  }
}
