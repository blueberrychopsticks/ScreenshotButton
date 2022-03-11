//
//  ScreenshotButtonApp.swift
//  ScreenshotButton
//
//  Created by laptop on 3/7/22.
//

import Foundation
import SwiftUI

@main
struct ScreenshotButtonApp: App {
  @AppStorage("tapCount") private var tapCount = 0
  @AppStorage("otter") private var otter =
    "If you're recording an Otter, paste it here. Eventually, I hope this can automatically detect if you're recording one of any publicly available voice to text transcriptions. And I hope the price of them goes down for all of those services, and will do everything in my power to maximize the uncomplicated individual's access to powerful organizational tools such as quality voice transcription with hot word custom mapping."
  @AppStorage("path") private var path = "/Users/laptop/Desktop/"
  @AppStorage("prefix") private var prefix = ""

  @State var hidden = false
  var body: some Scene {
    let defaultSize = 850.0
    let hiddenSize = 1.0
    let size = hidden ? hiddenSize : defaultSize
    WindowGroup {
      ContentView(otter: $otter, path: $path, prefix: $prefix, hidden: $hidden)
        .frame(
          minWidth: size, maxWidth: size, idealHeight: size)
    }
  }
}

// change this to TCA and consume state rather than state providers
//struct ContextProviders {
//   var otter: Binding<String>;
//   var path: Binding<String>;
//   var prefix: Binding<String>;
//
//  init(_ otter: String, _ path: String, _ prefix: String) {
//    self.otter = Binding(
//      get: {self.otter},
//      set: {self.otter = $0}
//    )
//    self.path = Binding(
//      get: {self.path},
//      set: {self.path = $0}
//    )
//
//    self.prefix = Binding(Binding<V>
//      get: {self.prefix},
//      set: {self.prefix = $0}
//    )
//
//
//  }
//}
