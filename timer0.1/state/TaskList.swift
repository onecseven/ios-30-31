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

enum TaskListError: Error {
    case EmptyTasklist
}

enum TaskListDirection {
  case top
  case bottom
}


class TaskList {
  var tasks: [Task] = [STOP_TASK]
  var isLooping: Bool = false
  var next: Int = 0 // tasks index
// https://www.hackingwithswift.com/articles/117/the-ultimate-guide-to-timer
  var state: TimerState = TimerState.IDLE

  var currentTask: Task? {
    return tasks.first
  }
  
  func start() {
    if state != TimerState.RUNNING {
      state = TimerState.RUNNING
    }
  }
  
  func stop() {
    if (state == TimerState.RUNNING) {
      state = TimerState.STOPPED
    }
  }

  func bump() {
    let temp = tasks.remove(at: 0)
    tasks.append(temp)
    tasks.last?.refill()
  }
  
  func rearrange(index: Int, sendTo: TaskListDirection) {
    let temp = tasks.remove(at: index)
    switch sendTo {
      case TaskListDirection.bottom:
        tasks.append(temp)
      case TaskListDirection.top:
        tasks.insert(temp, at: 0)
    }
  }
  
  func addTask(task: Task) {
    tasks.append(task)
  }
  
  func deleteTask(index: Int) {
    tasks.remove(at: index)
  }
  
}

