//
//  timer0_1App.swift
//  timer0.1
//
//  Created by Tatiana Talavera on 06-06-23.
//

import SwiftUI

@main
struct timer0_1App: App {
  var body: some Scene {
    WindowGroup {
        ContentView()
        }
    }
}

class Task {
  var name: String
  var duration: Int
  var icon: String
  var color: String
  var remaining: Int
  func tick() {}
  func addTime() {}
  init(name: String, duration: Int, icon: String, color: String) {
    self.name = name
    self.duration = duration
    self.icon = icon
    self.color = color
    self.remaining = duration
  }
}

let STOP_TASK: Task = Task(name: "_STOP", duration: 0, icon: "", color: "")

func isStopTask(_ task: Task) -> Bool {
  return task.name == "_STOP"
}

enum TimerState {
  case IDLE
  case RUNNING
  case STOPPED
}

class TaskList {
  var tasks: [Task] = [STOP_TASK]
  var isLooping: Bool = false
  var next: Int = 0 // tasks index
  var state: TimerState = TimerState.IDLE
  var currentTask: Task? = nil
  func start() {}
  func stop() {}
  func bump() {}
  func rearrange() {}
}

var pollo = TimerTask(name: "pollo", seconds: 2, icon: "po", color: "lol", remaining: 1)
