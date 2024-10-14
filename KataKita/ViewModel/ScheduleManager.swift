//
//  ScheduleManager.swift
//  KataKita
//
//  Created by Alvito Dwi Reza on 11/10/24.
//

import Foundation

// Managing Schedule Data (schedule per day in a week)

@Observable
class ScheduleManager {
    var schedules: [Schedule]
    
    init() {
        self.schedules = [
            Schedule(id: UUID(), day: .MONDAY([])),
            Schedule(id: UUID(), day: .TUESDAY([])),
            Schedule(id: UUID(), day: .WEDNESDAY([])),
            Schedule(id: UUID(), day: .THURSDAY([])),
            Schedule(id: UUID(), day: .FRIDAY([])),
            Schedule(id: UUID(), day: .SATURDAY([])),
            Schedule(id: UUID(), day: .SUNDAY([]))
        ]
    }
    
    func addActivity(_ activity: Activity, day: Day) {
        var newDay = day;
        if case var .MONDAY(activities) = day {
            activities.append(activity)
            newDay = .MONDAY(activities)
        }
        if case var .TUESDAY(activities) = day {
            activities.append(activity)
            newDay = .TUESDAY(activities)
        }
        if case var .WEDNESDAY(activities) = day {
            activities.append(activity)
            newDay = .WEDNESDAY(activities)
        }
        if case var .THURSDAY(activities) = day {
            activities.append(activity)
            newDay = .THURSDAY(activities)
        }
        if case var .FRIDAY(activities) = day {
            activities.append(activity)
            newDay = .FRIDAY(activities)
        }
        if case var .SATURDAY(activities) = day {
            activities.append(activity)
            newDay = .SATURDAY(activities)
        }
        if case var .SUNDAY(activities) = day {
            activities.append(activity)
            newDay = .SUNDAY(activities)
        }
        updateDay(newDay)
    }
    
    func removeActivity(index: Int, day: Day) {
        var newDay = day;
        if case var .MONDAY(activities) = day {
            if(activities.count > index) {
                activities.remove(at: index)
            }
            newDay = .MONDAY(activities)
        }
        if case var .TUESDAY(activities) = day {
            if(activities.count > index) {
                activities.remove(at: index)
            }
            newDay = .TUESDAY(activities)
        }
        if case var .WEDNESDAY(activities) = day {
            if(activities.count > index) {
                activities.remove(at: index)
            }
            newDay = .WEDNESDAY(activities)
        }
        if case var .THURSDAY(activities) = day {
            if(activities.count > index) {
                activities.remove(at: index)
            }
            newDay = .THURSDAY(activities)
        }
        if case var .FRIDAY(activities) = day {
            if(activities.count > index) {
                activities.remove(at: index)
            }
            newDay = .FRIDAY(activities)
        }
        if case var .SATURDAY(activities) = day {
            if(activities.count > index) {
                activities.remove(at: index)
            }
            newDay = .SATURDAY(activities)
        }
        if case var .SUNDAY(activities) = day {
            if(activities.count > index) {
                activities.remove(at: index)
            }
            newDay = .SUNDAY(activities)
        }
        updateDay(newDay)
    }
    
    func removeAll(_ day: Day) {
        var newDay = day;
        if case var .MONDAY(activities) = day {
            activities.removeAll()
            newDay = .MONDAY(activities)
        }
        if case var .TUESDAY(activities) = day {
            activities.removeAll()
            newDay = .TUESDAY(activities)
        }
        if case var .WEDNESDAY(activities) = day {
            activities.removeAll()
            newDay = .WEDNESDAY(activities)
        }
        if case var .THURSDAY(activities) = day {
            activities.removeAll()
            newDay = .THURSDAY(activities)
        }
        if case var .FRIDAY(activities) = day {
            activities.removeAll()
            newDay = .FRIDAY(activities)
        }
        if case var .SATURDAY(activities) = day {
            activities.removeAll()
            newDay = .SATURDAY(activities)
        }
        if case var .SUNDAY(activities) = day {
            activities.removeAll()
            newDay = .SUNDAY(activities)
        }
        updateDay(newDay)
    }
    
    private func updateDay(_ day: Day) {
        if let index = self.schedules.firstIndex(where: {$0.day == day}) {
            self.schedules[index].day = day
        }
    }
}

