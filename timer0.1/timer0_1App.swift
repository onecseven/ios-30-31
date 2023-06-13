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
  var pol: String {
    return ""
  }
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

