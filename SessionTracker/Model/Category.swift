//
//  SessionCategory.swift
//  SessionTracker
//
//  Created by Andrea Oquendo on 19/12/23.
//

import SwiftUI

struct Category: Identifiable {
    let id = UUID()
    var name: String
    var tintColor: String
    
    init(name: String, tintColor: TintColor) {
        self.name = name
        self.tintColor = tintColor.color
    }
    
    var color: Color {
        return tints.first(where: {$0.color == tintColor})?.value ?? appTint
    }
}
