//
//  Task.swift
//  iOSRecruitment
//
//  Created by Claire HUANG on 18/06/2020.
//  Copyright © 2020 cheerz. All rights reserved.
//

import UIKit

class Task :NSObject, NSCoding {
    
    // MARK: - Attribute
    var title: String?
    var isDone: Bool?
    var details: String?
    var color: UIColor?
    var identifier: String = UUID().uuidString

    let titleKey = "title"
    let isDoneKey = "isDone"
    let detailsKey = "details"
    let colorKey = "color"
    let identifierKey = "identifier"
    
    
    // MARK: - Initialisation
    init(_ title: String, details: String = "", isDone: Bool = false, color: UIColor = UIColor.systemGreen) {
        // init only title is mandatory
        self.title = title
        self.details = details
        self.isDone = isDone
        self.color = color
    }

    // MARK: - Encoder and Decoder
    func encode(with aCoder:NSCoder){
        aCoder.encode(title, forKey: titleKey)
        aCoder.encode(isDone, forKey: isDoneKey)
        aCoder.encode(details, forKey : detailsKey)
        aCoder.encode(color, forKey: colorKey)
        aCoder.encode(identifier, forKey: identifierKey)
    }
    
    required init(coder aDecoder:NSCoder) {
        guard let title = aDecoder.decodeObject(forKey: titleKey) as? String,
              let isDone = aDecoder.decodeObject(forKey: isDoneKey) as? Bool,
              let details = aDecoder.decodeObject(forKey: detailsKey) as? String,
              let color = aDecoder.decodeObject(forKey:colorKey) as? UIColor,
              let identifier = aDecoder.decodeObject(forKey:identifierKey) as? String
            else {
                return
              }
        self.color = color
        self.title = title
        self.isDone = isDone
        self.details = details
        self.identifier = identifier
    }
}
