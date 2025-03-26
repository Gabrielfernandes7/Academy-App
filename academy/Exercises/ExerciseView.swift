import SwiftUI
import SwiftData

struct ExerciseView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var workouts: [WorkoutModel]

    var body: some View {
        NavigationView {
            List {
                ForEach(workouts) { workout in
                    Section(header: Text(workout.title).font(.headline)) {
                        ForEach(workout.exercises, id: \.name) { exercise in
                            VStack(alignment: .leading, spacing: 5) {
                                Text(exercise.name)
                                    .font(.subheadline)
                                    .bold()
                                HStack {
                                    Text("\(exercise.sets)x de \(exercise.reps)")
                                    Text("Carga: \(exercise.weight ?? 0)kg")
                                }
                                .font(.footnote)
                                .foregroundColor(.gray)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Exercícios")
        }
    }
}

#Preview {
    ExerciseView()
}
