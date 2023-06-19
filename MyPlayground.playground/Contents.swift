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

class STOP_TASK: Task {
  init() {
    super.init(name: "_STOP", duration: 0, icon: "", color: "")
  }
}


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
  var next: Int = 0 // tasks index
  var tState: InternalTimerState = InternalTimerState()
  
  var state: TimerState {
    return tState.state
  }
  
  var timer: Timer = Timer()
  
  var currentTask: Task? {
    return tasks.first
  }
  
  @objc func tick() throws {
    let ame = currentTask?.name
    print("tick", ame)
    if state != TimerState.RUNNING {
      return
    }
    
    if let running = currentTask?.tick() {
      if !running {
        print("bump")
        bump()
      }
    } else {
      throw TaskListError.NoCurrentTask
    }
  }
  


  init(withTasks: [Task]) {
    tasks = withTasks
    if (!withTasks.contains(where: { $0 is STOP_TASK })) {
      tasks.append(STOP_TASK())
    }
    timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(tick), userInfo: nil, repeats: true)
    RunLoop.current.add(timer, forMode: .common)
  }
  
      
  func start() {
    tState.isRunning()
  }
  
  func stop() {
    tState.isStopped()
    print("stopped")
  }

  func bump() {
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



let taskos = [Task(name: "uno", duration: 65, icon: "", color: ""),Task(name: "dos", duration: 2, icon: "", color: ""), Task(name: "tres", duration: 2, icon: "", color: "")]

let first_one = TaskList(withTasks: taskos)

first_one.isLooping = true

first_one.start()

first_one.currentTask?.addTime()

print(first_one.tasks.map({ $0.name }))

// first_one.rearrange(index: 3, sendTo: TaskListDirection.top)


