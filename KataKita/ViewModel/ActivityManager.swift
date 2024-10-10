//
//  ActivityManager.swift
//  KataKita
//
//  Created by Alvito Dwi Reza on 11/10/24.


import Foundation
import UIKit

@Observable
class ActivityManager {
    var activity: Activity
    
    init(_ activity: Activity = Activity(id: UUID(), name: "new activity", image: nil, sequence: [] )) {
        self.activity = activity
    }
    // Kek ono underscore ben gausah ngisi
    func addStep(_ step: Step) {
        self.activity.sequence.append(step)
    }
    
    func removeStep(_ index: Int) {
        if(self.activity.sequence.count > index) {
            self.activity.sequence.remove(at: index)
        }
    }
    
    func setName(name: String) {
        self.activity.name = name
    }
    
    func setImage(image: String) {
        // Process image as String
    }
    func setImage(image: UIImage) {
        // Process image from camera / URL
    }
    
}
