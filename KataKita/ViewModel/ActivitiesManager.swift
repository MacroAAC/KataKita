//
//  ActivitiesManager.swift
//  KataKita
//
//  Created by Alvito Dwi Reza on 11/10/24.
//

import Foundation

@Observable
class ActivitiesManager {
    var activities : [Activity]
    
    init(_ activities: [Activity] = []) {
        self.activities = activities
    }
    
    func addActivity(_ activity: Activity) {
        self.activities.append(activity)
    }
    
    func removeActivity(index: Int) {
        
    }
}
