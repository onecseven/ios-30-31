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
  @State var tList: TaskList = TaskList(withTasks: [Task(name: "First", duration: 300, icon: "", color: ""), Task(name: "Second", duration: 600, icon: "", color: "")])
  
    var body: some View {
      VStack{
        Text(tList.tasks[0].name)
          .padding()
          .onAppear(){
            print(TimerColors.gray)
          }
        Text("Duration: \(tList.tasks[0].remaining)")
        Button(action: { tList.bump() }) {
          Text("Start")
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
