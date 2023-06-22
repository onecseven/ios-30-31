//
//  ContentView.swift
//  timer0.1
//
//  Created by Tatiana Talavera on 06-06-23.
//

import SwiftUI

struct pollo {
  var text: String {
    return ""
  }
}

struct UIString : Identifiable{ //this seems really dumb for a List component
   let id = UUID()
   let val: String
}

//TODO
// 0. isLooping
// 1. Second view for adding and removing tasks
// add Task
// remove task
// 2. "Send to bottom"

struct ContentView: View {
  @StateObject var tList: TaskList = TaskList(withTasks: [Task(name: "First", duration: 3000, icon: "", color: ""), Task(name: "Second", duration: 4600, icon: "", color: "")] )
   
    var body: some View {
      VStack{
        Text(tList.currentTask.name)
        Text(String(tList.currentTask.remaining))
        Button(action: { self.tList.start() }) {
          Text("Start")
        }
        Button(action: { self.tList.stop() }) {
          Text("Stop")
        }
        Button(action: { self.tList.rearrange(taskIndex: 0, sendTo: tList.tasks.count  - 1 ) }) {
          Text("Bump")
        }
        Button(action: { self.tList.add_time() }) {
          Text("Add Time")
        }
        Button(action: { self.tList.take_time() }) {
          Text("Take Time")
        }
        
        List(tList.tasks.map({ UIString(val: $0.name) })) {
          Text($0.val)
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
}
