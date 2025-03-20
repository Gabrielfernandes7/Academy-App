import SwiftUI

struct WorkView: View {
    
    
    @State var workouts: [WorkoutModel] = [
        WorkoutModel(title: "Supino Reto", repetition: "3 x 12 a 15", weight: 40),
        WorkoutModel(title: "Supino Inclinado", repetition: "3 x 12 a 15", weight: 20)
    ]
    
    var body: some View {
        Section {
            ForEach(workouts){
                workout in WorkoutCardView(workout: workout).swipeActions{
                        Button(role: .destructive){
                            workouts.removeAll {
                                cardWorkouts in cardWorkouts.id == workout.id
                            }
                        } label: {
                            Label {
                                Text("Delete")
                            } icon: {
                                Image(systemName: "Trash")
                            }
                        }
                    }
            }
        }    }
}


#Preview {
    WorkView()
}



