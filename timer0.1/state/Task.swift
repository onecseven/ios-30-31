//
//  File.swift
//  timer0.1
//
//  Created by Tatiana Talavera on 12-06-23.
//

import Foundation




class Task {
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
  
  func tick() -> Bool {
    if remaining > 0 {
      remaining -= 1
      return true
    } else {
      return false
    }
  }
  
  func refill() {
    remaining = duration
  }
  
  func addTime() {
    let potential = quickChangeValue + remaining
    if potential > duration {
      remaining = duration
    } else {
      remaining = potential
    }
  }
  
  func takeTime()  {
    let potential = quickChangeValue - remaining
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
}

class STOP_TASK: Task {
  init() {
    super.init(name: "_STOP", duration: 0, icon: "", color: "")
  }
}


