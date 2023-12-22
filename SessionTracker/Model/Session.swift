//
//  Session.swift
//  SessionTracker
//
//  Created by Andrea Oquendo on 19/12/23.
//

import SwiftUI
import SwiftData

@Model
class Session {
    
    var date: Date
    
    var durationHour: Int
    var durationMinutes: Int
    
    
    var duration: Float {
        if durationHour > 0 {
            let value = Float(durationHour) + Float(durationMinutes)/60
            return value
        }
        return Float(durationMinutes)
    }
    
    var durationPrefix: String {
        if durationHour > 0 {
            return "hrs"
        }
        
        return "min"
    }
    
    init(date: Date, durationHour: Int, durationMinutes: Int) {
        self.date = date
        self.durationHour = durationHour
        self.durationMinutes = durationMinutes
    }
    
}
