//
//  TaskList.swift
//  timer0.1
//
//  Created by Tatiana Talavera on 12-06-23.
//

import Foundation

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
