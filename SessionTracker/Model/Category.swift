//
//  SessionCategory.swift
//  SessionTracker
//
//  Created by Andrea Oquendo on 19/12/23.
//

import SwiftUI
import SwiftData

@Model
class Category {

    var name: String
    var emoji: String
    var tintColor: String
    
    @Relationship(deleteRule: .cascade)
    var sessions = [Session]()
    
    init(name: String, emoji: String, tintColor: TintColor) {
        self.name = name
        self.emoji = emoji
        self.tintColor = tintColor.color
    }
    
    var color: Color {
        return tintColors.first(where: {$0.color == tintColor})?.value ?? appTint
    }
    
    
    @Transient var totalDuration: Float {    
        var hours = 0
        var minutes = 0
        
        for session in sessions {
            hours += session.durationHour
            minutes += session.durationMinutes
        }
        
        let total = Float(hours) + Float(minutes)/60
        
        return total
    }
    
    @Transient var totalDurationInMinutes: Int {
        var total = 0
        
        for session in sessions {
            total += session.durationHour*60
            total += session.durationMinutes
        }
        
        return total
    }
    
    @Transient var sessionCount: Int {
        return sessions.count
    }

}
