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

struct ContentView: View {
  @StateObject var tList: TaskList = TaskList(withTasks: [Task(name: "First", duration: 300, icon: "", color: ""), Task(name: "Second", duration: 600, icon: "", color: "")])
   
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
