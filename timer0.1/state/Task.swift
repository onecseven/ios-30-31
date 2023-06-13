//
//  File.swift
//  timer0.1
//
//  Created by Tatiana Talavera on 12-06-23.
//

import Foundation


class Task {
  var name: String
  var duration: Int
  var icon: String
  var color: String
  var remaining: Int
  
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
  
  func addTime() {}
  func takeTime() {}

  
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

let STOP_TASK: Task = Task(name: "_STOP", duration: 0, icon: "", color: "")

