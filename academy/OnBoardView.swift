//
//  OnBoardView.swift
//  ProjetoAcademy
//
//  Created by User on 17/03/25.
//

import SwiftUI

struct OnBoardView: View {
    
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    
    var body: some View {
        NavigationStack{
            VStack{
                Image(systemName: "figure.walk.circle")
                    .imageScale(.large)
                    .foregroundStyle(.tint).font(.system(size: 100))
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore").frame(maxWidth: 350)
                NavigationLink( destination: ContentView()) {
                    Text("Continuar").foregroundStyle(.white).padding(.horizontal, 50).padding(.vertical, 15).background(Color.blue).cornerRadius(15).padding()
                }
                
            }
        }.preferredColorScheme(isDarkMode ? .dark : .light)
        
    }
}

#Preview {
    OnBoardView()
}
