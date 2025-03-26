//
//  academyApp.swift
//  academy
//
//  Created by user on 14/03/25.
//

import SwiftUI

@main
struct academyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [WorkoutModel.self, Exercise.self])
    }
}
