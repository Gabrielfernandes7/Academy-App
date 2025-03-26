import SwiftUI

struct AddWorkoutView: View {
    
    let workouts = Bundle.main.decode([WorkoutModelJSON].self, from: "Exercices.json")
    
    @State private var workoutName: String = ""
    @State private var selectedExercises: Set<ExerciseJSON> = []
    @Environment(\.dismiss) var dismiss
    
    @Environment(\.modelContext) var modelContext
    
    
    var categorizedExercises: [String: [ExerciseJSON]] {
        Dictionary(grouping: workouts.flatMap { $0.exercises }) { $0.categoria }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Digite o nome do treino", text: $workoutName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                List {
                    ForEach(categorizedExercises.keys.sorted(), id: \.self) { category in
                        Section(header: Text(category).font(.headline)) {
                            ForEach(categorizedExercises[category] ?? [], id: \.name) { exercise in
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(exercise.name)
                                            .font(.subheadline)
                                            .bold()
                                        HStack {
                                            Text("Séries: \(exercise.sets ?? 0)")
                                            Text("Reps: \(exercise.reps ?? 0)")
                                            Text("Carga: \(exercise.weight ?? 0) kg")
                                        }
                                        .font(.footnote)
                                        .foregroundColor(.gray)
                                    }
                                    Spacer()
                                    Button(action: {
                                        toggleSelection(for: exercise)
                                    }) {
                                        Image(systemName: selectedExercises.contains(exercise) ? "checkmark.square.fill" : "square")
                                            .foregroundColor(selectedExercises.contains(exercise) ? .blue : .gray)
                                    }
                                    .buttonStyle(BorderlessButtonStyle())
                                }
                                .padding(.vertical, 4)
                            }
                        }
                    }
                }
                
                Button("Salvar") {
                    saveSelectedExercises()
                }
                .padding()
                .disabled(workoutName.isEmpty || selectedExercises.isEmpty)
            }
            .navigationTitle("Criar Treino")
        }
    }
    
    private func toggleSelection(for exercise: ExerciseJSON) {
        if selectedExercises.contains(exercise) {
            selectedExercises.remove(exercise)
        } else {
            selectedExercises.insert(exercise)
        }
    }
    
    private func saveSelectedExercises() {
        let newWorkout = WorkoutModel(title: workoutName, icon: "")
//        modelContext.insert(newWorkout)
        for selected in selectedExercises {
            let exercice = Exercise(
                name: selected.name,
                sets: selected.sets,
                reps: selected.reps,
                weight: selected.weight,
                workout: newWorkout
            )
            newWorkout.exercises.append(exercice)
        }
        modelContext.insert(newWorkout)
        print("Treino Criado: \(newWorkout)")
        dismiss()
    }
}

#Preview {
    AddWorkoutView()
}
