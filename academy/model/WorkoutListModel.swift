import SwiftUI
import SwiftData

// CRIAR TREINO
@Model
class WorkoutModel {
    var title: String
    var icon: String
    
    @Relationship(deleteRule: .cascade) var exercises: [Exercise] = [] // Array de exercícios

    init(title: String, icon: String = "figure.walk", exercises: [Exercise] = []) {
        self.title = title
        self.icon = icon
        self.exercises = exercises
    }
}

struct WorkoutModelJSON: Decodable {
    var title: String
    var icon: String
    let exercises: [ExerciseJSON]
}

// LISTA DE EXERCICIOS
@Model
class Exercise {
    var name: String
    var sets: Int
    var reps: Int
    var weight: Int
    var workout: WorkoutModel?
    
    init(name: String, sets: Int, reps: Int, weight: Int, workout: WorkoutModel) {
        self.name = name
        self.sets = sets
        self.reps = reps
        self.weight = weight
        self.workout = workout
    }
}

struct ExerciseJSON: Decodable, Hashable {
    let name: String
    let sets: Int
    let reps: Int
    let weight: Int
    let categoria: String
}
