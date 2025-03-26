import SwiftUI

struct AddWorkoutView: View {
    
    let workouts = Bundle.main.decode([WorkoutModelJSON].self, from: "Exercices.json")
    
    @State private var workoutName: String = ""
    @State private var selectedExercises: Set<ExerciseJSON> = []
    @Environment(\.dismiss) var dismiss
    
    @Environment(\.modelContext) var modelContext
    
    @State private var mostrarAlerta = false
    @State private var selectedImage: String? = nil
        let images = ["Group 35", "Icone do treino", "Icone do treino-2", "Icone do treino-3"]
    
    
    var categorizedExercises: [String: [ExerciseJSON]] {
        Dictionary(grouping: workouts.flatMap { $0.exercises }) { $0.categoria }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Digite o nome do treino", text: $workoutName)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                VStack{
                    Text("Selecione um ícone")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading) // Alinha o texto à esquerda
                        .padding(.horizontal, 15)
                    HStack(spacing: 25) {
                        ForEach(images, id: \.self) { image in
                            ZStack {
                                if selectedImage == image {
                                    Rectangle()
                                        .stroke(Color.yellow, lineWidth: 13) // Borda amarela e mais espessa
                                        .frame(width: 80, height: 80) // Aumentando o tamanho da borda
                                        .cornerRadius(12)
                                        .shadow(color: .yellow, radius: 10, x: 0, y: 0) // Sombra amarela para destacar
                                }
                                Image(image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: selectedImage == image ? 80 : 70, height: selectedImage == image ? 80 : 70) // Aumenta o tamanho da imagem selecionada
                                    .clipShape(Rectangle()) // Mantém a forma retangular
                                    .onTapGesture {
                                        selectedImage = image
                                    }
                                    .cornerRadius(12)
                            }
                        }
                    }

                }
                

                
                List {
                    ForEach(categorizedExercises.keys.sorted(), id: \.self) { category in
                        Section(header: Text(category).font(.headline)) {
                            ForEach(categorizedExercises[category] ?? [], id: \.name) { exercise in
                                HStack {
                                    Image(systemName: "figure.highintensity.intervaltraining").font(.system(size: 30))
                                    VStack(alignment: .leading) {
                                        Text(exercise.name)
                                            .font(.subheadline)
                                            .bold()
                                        HStack {
                                            Text("\(exercise.sets ?? 0)x de \(exercise.reps)")
                                            Text("Carga: \(exercise.weight ?? 0)kg")
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
                                }.navigationBarItems(trailing: Button("Salvar") {
                                    saveSelectedExercises()
                                })
                                .padding(.vertical, 4)
                            }
                        }
                    }
                }
                
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
