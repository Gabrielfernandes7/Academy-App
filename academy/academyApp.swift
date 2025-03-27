import SwiftUI

@main
struct academyApp: App {
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false
    
    var body: some Scene {
        WindowGroup {
            if hasSeenOnboarding {
                ContentView()
            } else {
                OnBoardView()
                    .onDisappear {
                        hasSeenOnboarding = true
                    }
            }
        }
        .modelContainer(for: [WorkoutModel.self, Exercise.self])
    }
}
