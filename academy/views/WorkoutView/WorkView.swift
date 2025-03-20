import SwiftData
import SwiftUI

struct WorkView: View {
    @Environment(\.modelContext) var context

    @Query var workouts: [WorkoutModel]

    var body: some View {
        List {
            Button("Create") {
                createWorkout(WorkoutModel(title: "TITLE", repetition: "REPITITION", weight: 50))
            }
            Section {
                ForEach(workouts) { workout in
                    WorkoutCardView(workout: workout)
                        .swipeActions {
                            Button(role: .destructive) {
                                deleteWorkout(workout)
                            } label: {
                                Label {
                                    Text("Delete")
                                } icon: {
                                    Image(systemName: "Trash")
                                }
                            }
                        }
                }
            }
        }
    }

    func deleteWorkout(_ workout: WorkoutModel) {
        context.delete(workout)
        do {
            try context.save()
        } catch {
            print("Erro ao excluir")
        }
    }

    func createWorkout(_ workout: WorkoutModel) {
        context.insert(workout)
        do {
            try context.save()
        } catch {
            print("Treino nao registrado")
        }
    }
}

#Preview {
    WorkView()
        .modelContainer(for: WorkoutModel.self, inMemory: true)
}
