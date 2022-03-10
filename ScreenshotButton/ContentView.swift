//
//  ContentView.swift
//  ScreenshotButton
//
//  Created by laptop on 3/7/22.
//

import SwiftUI

struct ContentView: View {
//  var context: ContextProviders <~~ Tried it, need to convert to TCA rather than reinvent wheel
  @Binding var otter: String;
  @Binding var path: String;
  @Binding var prefix: String;
  @Binding var hidden: Bool;

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
      }.padding().onAppear {
        print(NSApplication.shared.windows)

      }.font(.largeTitle)
    }
}

/*
 * TODOS
 *
 * Create directory if it doesn't exist
 * Automatically prepend file name for easy organization and context in applications
 *   such as Notion where filenames are kept.
 * Take care of appending / to filepath if it isn't there
 * Remember previous configurations
 * Better layout
 * Single keyboard hotkey from anywhere (even if app is backgrounded)
 * TCA practice?
 */
