import SwiftUI

enum IconImages: String, CaseIterable {
    case icon1 = "Icone do treino-2"
    case icon2 = "Group 35"
    case icon3 = "Icone do treino"
    case icon4 = "Icone do treino-3"
}

struct AddWorkoutView: View {
    
    let workouts = Bundle.main.decode([WorkoutModelJSON].self, from: "Exercices.json")
    
    @State private var workoutName: String = ""
    @State private var selectedExercises: Set<ExerciseJSON> = []
    
    @State private var workoutIcon: String = "dumbbell"
    
    @Environment(\.dismiss) var dismiss
    
    @Environment(\.modelContext) var modelContext
    
    @State private var mostrarAlerta = false
    @State private var selectedImage: String? = nil
    let images = IconImages.allCases.map { icon in
        icon.rawValue
    }
    
    
    var categorizedExercises: [String: [ExerciseJSON]] {
        Dictionary(grouping: workouts.flatMap { $0.exercises }) { $0.categoria }
    }
    
    var isFormValid: Bool {
        !workoutName.isEmpty && !selectedExercises.isEmpty && selectedImage != nil
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack{
                    TextField("Digite o nome do treino", text: $workoutName)
                    //                    .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    Spacer()
                    Image(systemName: "pencil")
                        .padding(.horizontal, 15)
                        .font(.system(size: 25))
                }
                
                VStack{
                    Text("Selecione um ícone")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 15)
                    HStack(spacing: 25) {
                        ForEach(images, id: \.self) { image in
                            ZStack {
                                if selectedImage == image {
                                    Rectangle()
                                        .stroke(Color.yellow, lineWidth: 10)
                                        .frame(width: 80, height: 80)
                                        .cornerRadius(12)
                                        .shadow(color: .yellow, radius: 10, x: 0, y: 0)
                                }
                                Image(image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: selectedImage == image ? 80 : 70, height: selectedImage == image ? 80 : 70)
                                    .clipShape(Rectangle())
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
                                }
                                .padding(.vertical, 4)
                            }
                        }
                    }
                }
                
            }
            .navigationTitle("Criar Treino")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Salvar") {
                        saveSelectedExercises()
                    }
                    .disabled(!isFormValid)
                }
            }
        }
        .alert(isPresented: $mostrarAlerta) {
            Alert(
                title: Text("Erro"),
                message: Text("Preencha todos os campos."),
                dismissButton: .default(Text("Ok"))
            )
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
        if isFormValid {
            let newWorkout = WorkoutModel(title: workoutName, icon: selectedImage ?? "")
            
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
            
        } else {
            mostrarAlerta = true
        }
        
    }
}

#Preview {
    AddWorkoutView()
}
