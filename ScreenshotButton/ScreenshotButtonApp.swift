//
//  ScreenshotButtonApp.swift
//  ScreenshotButton
//
//  Created by laptop on 3/7/22.
//

/* TODO

    screenshot triggered from phone

	keyboard shortcut and toolbar item mandatory for helpful use

    change this to TCA and consume state rather than state providers

    have button follow close to a clickable area of the mouse drag after drag ends and debounces for a few milliseconds - not too slow to slow down user - not too fast to make it glitch. <sweet spot>

    git commit -- automatically link github based on git commit

    show error

    follow focus / show on all desktops

    copy (export) all text to markdown'ed links or json or variable names (or maybe even a resume
             ---- generator? talk to chris - that's one smart cookie)

    Create directory if it doesn't exist

    Automatically prepend file name for easy organization and context in applications
      such as Notion where filenames are kept.

    Take care of appending / to filepath if it isn't there

    Better layout

    Single keyboard hotkey from anywhere (even if app is backgrounded)

    TCA practice?



folder - /Users/laptop/Desktop/page 07 a1 12:54 start
        now = @March 10, 2022 1:23

 END TODO */

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
          minWidth: size,
          maxWidth: size,
          idealHeight: size
        )
    }
  }
}

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
