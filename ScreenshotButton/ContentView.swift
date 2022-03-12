//
//  ContentView.swift
//  ScreenshotButton
//
//  Created by laptop on 3/7/22.
//

import SwiftUI

struct ContentView: View {
  //  var context: ContextProviders <~~ Tried it, need to convert to TCA rather than reinvent wheel
  @Binding var otter: String
  @Binding var path: String
  @Binding var prefix: String
  @Binding var hidden: Bool

  var body: some View {
    VStack {
      /* TODO

	keyboard shortcut and toolbar item mandatory for helpful use

	some kind of indication of crash - audibly preferred - visuall on entire screen if muted

         have button follow close to a clickable area of the mouse drag after drag ends and debounces for a few milliseconds - not too slow to slow down user - not too fast to make it glitch. <sweet spot>

        git commit -- automatically link github based on git commit

        show error

        follow focus / show on all desktops

        copy (export) all text to markdown'ed links or json or variable names (or maybe even a resume
                 ---- generator? talk to chris - that's one smart cookie)

folder - /Users/laptop/Desktop/page 07 a1 12:54 start
        now = @March 10, 2022 1:23

         END TODO */

      // don't you see? these will be used at timestamped proof of work on
      // the blockchain
      // we just need a very neutral oracle; kind of like a loving wife.
      // most oracles, historically speaking, tear a man's ego to shreds.
      // Living with a great wife as a neutral oracle is likely to grant
      // him quite soft beds. Beautiful decor, hard tough love. The exact
      // thing you need, and you need quite a love. When you dance on that
      // machine, you require your hand, gloved.
      // Tempo was off and I'm rather upset.
      // Commenting in xCode, what a faGGET.
      // Sorry for language we should get over it.
      // Real problems near Russia that's all that I'll write.
      // If we all work together we'll all be all right.
      // Torn apart how we are? We're destined for ruin.
      // DAFUQ rhymes with that word -- Marshall McKlewin? ---         Herbert Marshall McLuhan CC was a Canadian philosopher whose work is among the cornerstones of the study of media theory. Born in Edmonton, Alberta, and raised in Winnipeg, Manitoba, McLuhan studied at the University of Manitoba and the University of Cambridge. Wikipedia
      // BONUS spell that name right within seconds of hearing it. --- Marshall McLuhan
      // Or else suffer your losses, because I'm done rhyming. Games up!

      // Thursday, March 10, 2022, 0216 AM
      // - War in Ukraine. Apparently unprovoked being attacked by global "super" power. 40 miles of tanks freezing in the Tundra says otherwise. But prayers are with soldiers on the Ukranian front that they are able to safely (survive doesn't seem respectable enough a word anymore :( ) <<|~~< the dart hitting the frog indicates great sadness. sorry I sound like an idiot to you, I'm just trying to learn what it is that entertains a person like you or us anymore? with money? idk... it's all I've got right now. Cheeres all.
      // https://enoemos.notion.site/Page-7-Users-laptop-Desktop-page-07-a1-12-54-start-d5cea601cad64c38a604c58a10e89e29
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
