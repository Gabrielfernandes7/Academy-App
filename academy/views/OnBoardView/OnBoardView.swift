//
//  OnBoardView.swift
//  ProjetoAcademy
//
//  Created by User on 17/03/25.
//

import SwiftUI


struct OnBoardView: View {
    
    let image = "mascote"
    
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    
    var body: some View {
        NavigationStack{
            VStack{
                VStack{
                    Image("mascote")
                        .imageScale(.large)
                        .foregroundStyle(.tint).font(.system(size: 50))
                    Text("NomeApp").frame(maxWidth: 350).font(.title)
                }.padding(.top, 150)
                Spacer()
                NavigationLink( destination: ContentView()) {
                    Text("Continuar").foregroundStyle(.white).padding(.horizontal, 70).padding(.vertical, 18).background(Color.green).cornerRadius(50).padding().bold()                }
                
            }
        }.preferredColorScheme(isDarkMode ? .dark : .light)
        
    }
}

#Preview {
    OnBoardView()
}
