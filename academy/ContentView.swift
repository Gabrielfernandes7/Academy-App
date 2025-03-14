//
//  ContentView.swift
//  academy
//
//  Created by user on 14/03/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "star")
                .imageScale(.large)
                .foregroundStyle(.tint)
                .colorScheme(ColorScheme.light)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
