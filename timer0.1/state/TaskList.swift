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



class TaskList: ObservableObject {
  @Published var tasks: [Task] = [STOP_TASK]
  @Published var isLooping: Bool = false
  @Published var tState: InternalTimerState = InternalTimerState()
  @Published var currentTask: Task = STOP_TASK
  var timer: Timer = Timer()

  enum TaskListDirection {
    case top
    case bottom
  }
  
  var state: TimerState {
    return tState.state
  }
  
  @objc private func tick() throws {
    
    if state != TimerState.RUNNING {
      return
    }
    
    if tasks[0].tick() {
      print("---")
      tasks.map(_: { print($0.name, $0.remaining) })
    } else {
      print("Ended")
      bump()
    }
  }
  
  init(withTasks: [Task]) {
    tasks = withTasks
    if (!withTasks.contains(where: { $0.name == "_STOP" })) {
      tasks.append(STOP_TASK)
    }
    currentTask = tasks[0]
  }
  
  private func new_timer() {
    timer.invalidate()
    timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(tick), userInfo: nil, repeats: true)
    RunLoop.current.add(timer, forMode: .common)
  }
  
  func start() {
    tState.isRunning()
    new_timer()
  }
  
  // remove the next two things
  func add_time() {
    tasks[0].addTime()
  }
  func take_time() {
    tasks[0].takeTime()
  }
  // stop deleting
  private func done() {
    tState.isIdle()
    timer.invalidate()
  }
  
  func stop() {
    tState.isStopped()
  }

  private func bump() { //default movement behavior i.e when task is over, next one rolls over or the execution stops
    tState.isLoading()
    var temp = tasks.remove(at: 0)
    if (temp.name == "_STOP" && !isLooping) {
      stop()
    }
    temp.refill()
    tasks.append(temp)
    tState.doneLoading()
  }
  
  func rearrange(taskIndex: Int, sendTo: TaskListDirection) {
    tState.isLoading()

    //what0 happens if index === 0 and sendTo top
    let temp = tasks.remove(at: taskIndex)
    switch sendTo {
      case TaskListDirection.bottom:
        tasks.append(temp)
      case TaskListDirection.top:
        tasks.insert(temp, at: 0)
    }
    tState.doneLoading()
  }
  
  func rearrange(taskIndex: Int, sendTo: Int) {
    tState.isLoading()
    let temp = tasks.remove(at: taskIndex)
    tasks.insert(temp, at: sendTo)
    tState.doneLoading()
  }
    
  func deleteTask(index: Int) {
    tState.isLoading()

    tasks.remove(at: index)
    tState.doneLoading()
  }
}

