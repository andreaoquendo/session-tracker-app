//
//  Session.swift
//  SessionTracker
//
//  Created by Andrea Oquendo on 19/12/23.
//

import SwiftUI

struct Session: Identifiable {
    let id: UUID = .init()
    
    var iniDate: Date
    var endDate: Date
    var duration: Float
    var category: Category
    
    init(iniDate: Date, endDate: Date, duration: Float, category: Category) {
        self.iniDate = iniDate
        self.endDate = endDate
        self.duration = duration
        self.category = category
    }
    
}
