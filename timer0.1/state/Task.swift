//
//  File.swift
//  timer0.1
//
//  Created by Tatiana Talavera on 12-06-23.
//

import Foundation




struct Task {
  enum taskStatus {
    case OVER
    case FULL
    case TICKING
  }
 var name: String
 var duration: Int
 var icon: String
 var color: String
 var remaining: Int
  
  var status: taskStatus {
    switch remaining {
      case 0:
        return taskStatus.OVER
      case 1..<duration:
        return taskStatus.TICKING
      case duration:
        return taskStatus.FULL
      default:
        print("this should never happen")
        return taskStatus.OVER
      }
  }
  var quickChangeValue: Int {
    switch remaining {
      case 0..<60:
        return 0
      case 60..<600:
        return 60 // 5 min
      case 600..<3600:
        return 5 * 60 // 15 min
      case 3600..<7200:
        return 15 * 60
      case 7200..<72000:
        return 30 * 60
      default:
        return 0
      }
  }
  
  mutating func tick() -> Bool {
    if remaining > 0 {
      remaining -= 1
      return true
    } else {
      return false
    }
  }
  
  mutating func refill() {
    remaining = duration
  }
  
  mutating func addTime() {
    let potential = quickChangeValue + remaining
    print("Adding time: \(quickChangeValue/60)m")
    if potential > duration { // prevents task from having a remaining time higher than its duration
      remaining = duration
    } else if quickChangeValue == 0 { // adds 1 minute to tasks with a remaining value under 60
      remaining += 60
    } else { // happy path
      remaining = potential
    }
  }
  
  
  mutating func takeTime()  {
    let potential = abs(quickChangeValue - remaining)
    print("Taking time: -\(quickChangeValue/60)m")
    if potential < 0 {
      remaining = 0
    } else {
      remaining = potential
    }
  }

  
  static func isStopTask(_ task: Task) ->  Bool {
    return task.name == "_STOP"
  }
  

  init(name: String, duration: Int, icon: String, color: String) {
    self.name = name
    self.duration = duration
    self.icon = icon
    self.color = color
    self.remaining = duration
  }
  
  init(name: String, duration: Int, icon: String, color: String, remaining: Int) {
    self.name = name
    self.duration = duration
    self.icon = icon
    self.color = color
    self.remaining = remaining
  }
}

//class STOP_TASK: Task {
//  init() {
//    super.init(name: "_STOP", duration: 0, icon: "", color: "")
//  }
//}


let STOP_TASK = Task(name: "_STOP", duration: 0, icon: "", color: "")
