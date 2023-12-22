//
//  SessionTrackerApp.swift
//  SessionTracker
//
//  Created by Andrea Oquendo on 19/12/23.
//

import SwiftUI
import SwiftData

@main
struct SessionTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Category.self, Session.self])
    }
}
