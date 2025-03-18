//
//  ContentView.swift
//  ProjetoAcademy
//
//  Created by User on 17/03/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Treinos", systemImage: "dumbbell")
                }

            ConquestView()
                .tabItem {
                    Label("Conquistas", systemImage: "trophy")
                }

            ProfileView()
                .tabItem {
                    Label("Ajustes", systemImage: "gearshape")
                }
        }
    }
}

#Preview {
    ContentView()
}
