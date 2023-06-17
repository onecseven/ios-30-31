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
      remaining = remaining - 1
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

let STOP_TASK: Task = Task(name: "_STOP", duration: 0, icon: "", color: "")

var myTask = Task(name: "First", duration: 10, icon: "", color: "")

print(myTask.duration)
myTask.name

for _ in 1...10 {
  myTask.tick()
}
myTask.tick

myTask.name = "pollo"
print(myTask.remaining)

myTask.name


//
//  TaskList.swift
//  timer0.1
//
//  Created by Tatiana Talavera on 12-06-23.
//


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
}

let first_one = TaskList()

first_one.start()

first_one.tasks.append(Task(name: "uno", duration: 25, icon: "", color: ""))
first_one.tasks.append(Task(name: "dos", duration: 25, icon: "", color: ""))
first_one.tasks.append(Task(name: "tres", duration: 25, icon: "", color: ""))

first_one.rearrange(index: 3, sendTo: TaskListDirection.top)

first_one.tasks.map({ print($0.name) })

