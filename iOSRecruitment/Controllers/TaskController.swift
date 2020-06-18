//
//  TaskController.swift
//  iOSRecruitment
//
//  Created by Claire HUANG on 15/06/2020.
//  Copyright © 2020 cheerz. All rights reserved.
//

import UIKit

class TaskController: UITableViewController{
    
    var taskService : TaskService! {
        didSet {
            // get the data and reload tableView
            taskService.tasksList = TaskStorage.fetch() ?? [[Task](),[Task]()]
            tableView.reloadData()
        }
    }
    
    var sectionForInfo : Int!
    var rowForInfo : Int!

    @IBAction func unwindWithSegue(_ segue: UIStoryboardSegue) {}
    
    @objc func addTaskInTV(notification:Notification) -> Void{
           tableView.insertRows(at: [IndexPath.init(row: 0, section: 0)], with: .automatic)
    }
}

// MARK: - Override UIViewController
extension TaskController{
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView() // cut separators none necessary in the tableView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(addTaskInTV),
                                               name:Notification.Name("ADD_NEW_TASK"),
                                               object: nil)//register for notification
    }

    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let addNewTaskController = segue.destination as? AddNewTaskController {
            addNewTaskController.taskService = taskService
        }
        else if let checkInfoController = segue.destination as? checkInfoController,
            let taskIndexRow = tableView.indexPathForSelectedRow?.row,
            let taskIndexSection = tableView.indexPathForSelectedRow?.section
        {
            checkInfoController.titleToInfo = taskService.tasksList[taskIndexSection][taskIndexRow].title
            checkInfoController.detailsToInfo = taskService.tasksList[taskIndexSection][taskIndexRow].details
            checkInfoController.colorToInfo = taskService.tasksList[taskIndexSection][taskIndexRow].color
        }
    }
}

//MARK: - UITableViewDataSource
extension TaskController{
    override func numberOfSections(in tableView: UITableView) -> Int {
        return taskService.tasksList.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return taskService.tasksList[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TaskTVCell
        cell.titleLabel.text = taskService.tasksList[indexPath.section][indexPath.row].title
        cell.detailsLabel.text = taskService.tasksList[indexPath.section][indexPath.row].details
        cell.colorView.backgroundColor = taskService.tasksList[indexPath.section][indexPath.row].color
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Todo list": "Done list"
    }
}


//MARK: - UITableViewDelegate
extension TaskController{
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    override func tableView(_ tableView:UITableView, willDisplayHeaderView view: UIView,forSection section: Int){
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.init(red: 0.1, green: 0.1, blue: 0.4, alpha: 100)
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteSwip = UIContextualAction(style: .destructive, title: nil){
            (action, sourceView, completionHandler) in
            print(indexPath.section, indexPath.row)
            guard let isDone = self.taskService.tasksList[indexPath.section][indexPath.row].isDone else { return }
            self.taskService.removeTask(at: indexPath.row,isDone: isDone)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            completionHandler(true)
        }
        deleteSwip.title = "Delete"
        deleteSwip.backgroundColor = UIColor.systemRed
        return UISwipeActionsConfiguration(actions: [deleteSwip])
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let doneSwip = UIContextualAction(style: .normal, title: nil){
            (action, sourceView, completionHandler) in
            self.taskService.tasksList[0][indexPath.row].isDone = true
            let doneTask = self.taskService.removeTask(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            self.taskService.addTask(doneTask, at: 0, isDone: true)
            tableView.insertRows(at: [IndexPath.init(row: 0, section: 1)], with: .automatic)
            completionHandler(true)
        }
        doneSwip.title = "Done"
        doneSwip.backgroundColor = UIColor.systemGreen
        return indexPath.section == 0 ? UISwipeActionsConfiguration(actions:[doneSwip]) : nil
    }
    
}
