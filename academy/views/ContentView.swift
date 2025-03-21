import SwiftUI

struct ContentView: View {
    
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    @State private var isSheetPresented = false
    @State private var selectedTraining: String? = nil
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    Text("Local do calendário")
                }
                
                // Lista de Treinos
                Section {
                    TrainingRowView(title: "Treino A", icon: "person.crop.circle.fill", color: .pink)
                        .onTapGesture {
                            selectedTraining = "Treino A"
                            isSheetPresented.toggle()
                        }
                    
                    TrainingRowView(title: "Treino B e C", icon: "person.2.fill", color: .blue)
                        .onTapGesture {
                            selectedTraining = "Treino B e C"
                            isSheetPresented.toggle()
                        }
                    
                    TrainingRowView(title: "Treino D", icon: "sun.max.fill", color: .yellow)
                        .onTapGesture {
                            selectedTraining = "Treino D"
                            isSheetPresented.toggle()
                        }
                }
            }
            .navigationTitle("MuscleApp")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    HStack {
                        Spacer()
                        
                        NavigationLink(destination: ConquestView()){
                            Image(systemName: "trophy").foregroundColor(.primary)
                        }
                        
                        NavigationLink(destination: ProfileView(isDarkMode: $isDarkMode)){
                            Image(systemName: "gearshape").foregroundColor(.primary)
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .sheet(isPresented: $isSheetPresented) {
                if let training = selectedTraining {
                    TrainingDetailView(training: training)
                }
            }
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}

struct TrainingRowView: View {
    var title: String
    var icon: String
    var color: Color
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.white)
                .frame(width: 30, height: 30)
                .padding()
                .background(color)
                .clipShape(Circle())
            
            Text(title)
                .font(.headline)
            
            Spacer()
        }
        .padding(8)
        .background(Color(.systemGray6))
        .cornerRadius(8)
    }
}

struct TrainingDetailView: View {
    
    var training: String
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                
                Text(training)
                    .font(.title)
                    .bold()
                
                Text("Selecione um ícone")
                    .font(.headline)
                
                HStack {
                    TrainingIconView(icon: "person.crop.circle.fill", color: .pink)
                    TrainingIconView(icon: "person.2.fill", color: .blue)
                    TrainingIconView(icon: "sun.max.fill", color: .yellow)
                    TrainingIconView(icon: "moon.fill", color: .green)
                }
                
                ExerciseSection(title: "Peito", exercises: ["Supino Livre Reto", "Supino Polia"], color: .yellow)
                ExerciseSection(title: "Tríceps", exercises: ["Tríceps Corda", "Afundo"], color: .green)
                ExerciseSection(title: "Quadríceps", exercises: ["Agachamento Smith"], color: .blue)
                
                Spacer()
            }
            .padding()
            .navigationTitle("Detalhes do Treino")
        }
    }
}

struct TrainingIconView: View {
    var icon: String
    var color: Color
    
    var body: some View {
        Image(systemName: icon)
            .foregroundColor(.white)
            .frame(width: 40, height: 40)
            .background(color)
            .clipShape(Circle())
    }
}

struct ExerciseSection: View {
    var title: String
    var exercises: [String]
    var color: Color
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .foregroundColor(color)
            
            ForEach(exercises, id: \.self) { exercise in
                HStack {
                    Text(exercise)
                    Spacer()
                    Toggle("", isOn: .constant(false))
                }
                .padding(.vertical, 4)
            }
        }
    }
}

#Preview {
    ContentView()
}

