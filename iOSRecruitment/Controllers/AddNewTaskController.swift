//
//  addNewTaskController.swift
//  iOSRecruitment
//
//  Created by Claire HUANG on 15/06/2020.
//  Copyright © 2020 cheerz. All rights reserved.
//

import UIKit

class AddNewTaskController: UIViewController{

    @IBOutlet weak var titleTf: UITextField!
    @IBOutlet weak var detailsTV: UITextView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var yellowButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var redButton: UIButton!
    @IBOutlet weak var blackButton: UIButton!
    
    public var taskService: TaskService!
    fileprivate var colorChoosed: UIColor = UIColor.systemGreen
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTf.addTarget(self, action: #selector(self.manageTextChanges), for: .editingChanged)
        greenButton.backgroundColor = UIColor.systemGreen
        yellowButton.backgroundColor = UIColor.systemYellow
        blueButton.backgroundColor = UIColor.systemBlue
        redButton.backgroundColor = UIColor.systemRed
        blackButton.backgroundColor = UIColor.black
    }
    
    fileprivate func getColorChoosed() -> UIColor{
        return colorChoosed
    }
    
    // ManageTextChanges check each time the textField is modify is the the TF is empty and enable or not the add button
    // action to a specific target (when tf change)
    @objc private func manageTextChanges(_ sender: UITextField){
        guard let titleTf = titleTf.text
            else {return}
        let isTitleEmpty = titleTf.trimmingCharacters(in: .whitespaces).isEmpty
        addButton.isEnabled = !isTitleEmpty
        addButton.backgroundColor = isTitleEmpty == true ? UIColor.systemGray : UIColor.white
    }
    
    
    @IBAction func addButtonClicked(_ sender: UIButton) {
        guard let titleTf = titleTf.text,
              let detailsTV = detailsTV.text
            else {return}
        let colorChoosed: UIColor = getColorChoosed()
        let newTask = Task(titleTf, details: detailsTV, color: colorChoosed)
        taskService.addTask(newTask, at: 0)
    }
    
    @IBAction func colorButtonClicked(_ sender: UIButton) {
        colorChoosed = sender.backgroundColor!
        
        greenButton.layer.borderWidth = 0
        yellowButton.layer.borderWidth = 0
        blueButton.layer.borderWidth = 0
        redButton.layer.borderWidth = 0
        blackButton.layer.borderWidth = 0
        
        sender.layer.borderWidth = 2
        sender.layer.borderColor = UIColor.white.cgColor
    }
}
