//
//  TaskStorage.swift
//  iOSRecruitment
//
//  Created by Claire HUANG on 17/06/2020.
//  Copyright © 2020 cheerz. All rights reserved.
//

import Foundation

class TaskStorage {
        
    // archive
    private static func archive(_ tasks: [[Task]]) -> Data? {
        return try? NSKeyedArchiver.archivedData(withRootObject: tasks, requiringSecureCoding: false)
    }
    
    //fetch
    static func fetch() -> [[Task]]? {
        guard let unarchiveData = UserDefaults.standard.object(forKey: "tasks") as? Data else {return nil}
        do {
            guard let array = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(unarchiveData) as? [[Task]] else {
                fatalError("loadWidgetDataArray - Can't get Array")
            }
            return array
        } catch {
            fatalError("loadWidgetDataArray - Can't encode data: \(error)")
        }
       
    }
    
    //save
    static func save (_ tasksList : [[Task]]){
        let archivedTasks = archive(tasksList)
        UserDefaults.standard.set(archivedTasks, forKey: "tasks")
        UserDefaults.standard.synchronize()
        
    }
}
