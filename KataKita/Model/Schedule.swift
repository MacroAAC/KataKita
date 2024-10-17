//
//  Schedule.swift
//  KataKita
//
//  Created by Alvito Dwi Reza on 10/10/24.
//

import Foundation
import UIKit

/// Enum with inner value (Associated value)
enum Day : Equatable {
    case SUNDAY([Activity])
    case MONDAY([Activity])
    case TUESDAY([Activity])
    case WEDNESDAY([Activity])
    case THURSDAY([Activity])
    case FRIDAY([Activity])
    case SATURDAY([Activity])
    
    
    /// Operator overloading dayum!
    static func ==(lhs: Day, rhs: Day) -> Bool {
        switch(lhs, rhs) {
            case(.MONDAY(_), .MONDAY(_)): 
                return true
            case(.TUESDAY(_), .TUESDAY(_)): 
                return true
            case(.WEDNESDAY(_), .WEDNESDAY(_)): 
                return true
            case(.THURSDAY(_), .THURSDAY(_)): 
                return true
            case(.FRIDAY(_), .FRIDAY(_)): 
                return true
            case(.SATURDAY(_), .SATURDAY(_)): 
                return true
            case(.SUNDAY(_), .SUNDAY(_)): 
                return true
            default: 
                return false
        }
    }
    
    func extractActivities() -> [Activity] {
        switch self {
            case .SUNDAY(let activities): return activities
            case .MONDAY(let activities): return activities
            case .TUESDAY(let activities): return activities
            case .WEDNESDAY(let activities): return activities
            case .THURSDAY(let activities): return activities
            case .FRIDAY(let activities): return activities
            case .SATURDAY(let activities): return activities
        }
        
    }
}

// Dibutuhkan buat unique id dan enum hari
struct Schedule : Identifiable {
    var id: UUID
    var day: Day
}
