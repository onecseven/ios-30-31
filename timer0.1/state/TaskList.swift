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
  case LOADING
}

enum TaskListError: Error {
    case EmptyTasklist
    case NoCurrentTask
}

enum TaskListDirection {
  case top
  case bottom
}

struct InternalTimerState {
  var state: TimerState = TimerState.IDLE
  private var last: TimerState = TimerState.IDLE
  mutating func isLoading() {
    last = state
    state = TimerState.LOADING
  }
  
  mutating func doneLoading() {
    state = last
    last = TimerState.IDLE
  }
  mutating func isRunning() { state = TimerState.RUNNING }
  mutating func isIdle() { state = TimerState.IDLE }
  mutating func isStopped() { state = TimerState.STOPPED }
}



class TaskList {
  var tasks: [Task] = [STOP_TASK()]
  var isLooping: Bool = false
  private var tState: InternalTimerState = InternalTimerState()
  
  var state: TimerState {
    return tState.state
  }
  
  var timer: Timer = Timer()
  
  @objc func tick() throws {
    print("here")
    if state != TimerState.RUNNING {
      return
    }
    
    if let running = currentTask?.tick() {
      if !running {
        bump()
      }
    } else {
      throw TaskListError.NoCurrentTask
    }
  }
  
  var currentTask: Task? {
    return tasks.first
  }

  init(withTasks: [Task]) {
    tasks = withTasks
    if (!withTasks.contains(where: { $0 is STOP_TASK })) {
      tasks.append(STOP_TASK())
    }
  }
  
  private func new_timer() {
    timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(tick), userInfo: nil, repeats: true)
    RunLoop.current.add(timer, forMode: .common)
  }
      
  func start() {
    tState.isRunning()
  }
  
  func done() {
    tState.isIdle()
    timer.invalidate()
  }
  
  func stop() {
    tState.isStopped()
  }

  func bump() { //default movement behavior i.e when task is over, next one rolls over or the execution stops
    tState.isLoading()
    let temp = tasks.remove(at: 0)
    if (temp is STOP_TASK && !isLooping) {
      stop()
      return
    }
    tasks.append(temp)
    tasks.last?.refill()
    tState.doneLoading()
  }
  
  func rearrange(index: Int, sendTo: TaskListDirection) {
    tState.isLoading()

    //what happens if index === 0 and sendTo top
    let temp = tasks.remove(at: index)
    switch sendTo {
      case TaskListDirection.bottom:
        tasks.append(temp)
      case TaskListDirection.top:
        tasks.insert(temp, at: 0)
    }
       
    tState.doneLoading()
  }
  
  func addTask(task: Task) {
    tasks.append(task)
  }
  
  func deleteTask(index: Int) {
    tState.isLoading()

    tasks.remove(at: index)
    
    tState.doneLoading()
  }
}

