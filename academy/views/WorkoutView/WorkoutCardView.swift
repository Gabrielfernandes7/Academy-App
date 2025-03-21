//
//  WorkoutCardView.swift
//  academy
//
//  Created by User on 20/03/25.
//

import SwiftUI

struct WorkoutCardView: View {
    let workout: WorkoutModel
    
    var body: some View {
        HStack{
            Image(systemName: "figure.gymnastics").font(.system(size: 30))
            VStack(alignment: .leading){
                Text(workout.title)
                HStack{
                    Text("\(workout.repetition) rep.")
                    Text("\(workout.weight)kg")
                }

            }
            Spacer()
            Button {
                workout.isDone.toggle()
            } label: {
                Label {
                    Text("checkbox")
                } icon: {
                    Image(systemName: workout.isDone
                          ? "checkmark.square.fill"
                          : "square")
                }
                .labelStyle(.iconOnly)

            }
        }

    }
}

#Preview {
    WorkoutCardView(workout: WorkoutModel(title: "Supino Reto", repetition: "3 x 12 a 15", weight: 40))
}
