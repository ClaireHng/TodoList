//
//  CheckInfoController.swift
//  iOSRecruitment
//
//  Created by Claire HUANG on 18/06/2020.
//  Copyright © 2020 cheerz. All rights reserved.
//

import UIKit

class checkInfoController: UIViewController{

    var titleToInfo : String!
    var detailsToInfo : String!
    var colorToInfo: UIColor!
    
    @IBOutlet weak var titleTf: UITextField!
    @IBOutlet weak var colorView: UIButton!
    @IBOutlet weak var detailsTV : UITextView!
    
    override func viewWillAppear(_ animated: Bool) {
        titleTf.text = titleToInfo
        detailsTV.text = detailsToInfo
        colorView.backgroundColor = colorToInfo
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
