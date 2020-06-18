import Foundation


class TaskService {
    
    // tasksList will be seperated in 2 categories, taskList[0] will be a list of TODO Tasks and taskList[1] will be a list of DONE Tasks
    var tasksList = [[Task](),[Task]()]

    // func used to trigger the taskController notification (used for the add button in addNewTaskController)
    private func addTaskToControllerNotif(){
        NotificationCenter.default.post(name: Notification.Name("ADD_NEW_TASK"), object: nil) // post updated data
    }
    
    // func that add a task in the taskList in the corresponding category depending its isDone value
    public func addTask(_ task: Task, at index: Int, isDone: Bool = false){
        let category = isDone ? 1: 0
        tasksList[category].insert(task, at: index)
        isDone == false ? addTaskToControllerNotif() : nil
    }
    
    // func that remove a task from the taskList
    @discardableResult func removeTask(at index: Int, isDone: Bool = false) -> Task{
        let category = isDone ? 1: 0
        return tasksList[category].remove(at: index)
    }
}
