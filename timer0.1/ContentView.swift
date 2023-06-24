//
//  ContentView.swift
//  timer0.1
//
//  Created by Tatiana Talavera on 06-06-23.
//

import SwiftUI

struct UIString : Identifiable{ //this seems really dumb for a List component
   let id = UUID()
   let val: String
}

// COMPLETED
// 0. isLooping x
// 1. Second view for adding and removing tasks x
// add Task x
// TODO
// read https://stackoverflow.com/questions/65782079/pass-a-swiftui-view-that-has-its-own-arguments-as-a-variable-to-another-view-str
// that shows how to have views with parameters
// 0. New View That Edits Tasks
// 1. remove task
// 2. "Send to bottom"
// 3. Trim out the TaskList class
// 4. 

struct ContentView: View {
  var body: some View {
    
    NavigationView {
      TimerView()
    }
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
      Group {
        ContentView()
      }
    }
}
