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
    var buttonColor: Color = Color(red: 36/255, green: 138/255, blue: 61/255)
    
    var body: some View {
        NavigationStack{
            VStack{
                VStack{
                    Image("mascote")
                        .imageScale(.large)
                        .foregroundStyle(.tint).font(.system(size: 50))
                    Text("FitQuest").frame(maxWidth: 350).font(.system(size: 35))
                        .padding(.top, 70).foregroundStyle(buttonColor).bold()
                }.padding(.top, 150).foregroundStyle(buttonColor)
                Text("Desafios, conquistas e evolução no seu ritmo!").frame(maxWidth: 350).font(.title2).padding(.top, 20)
            }.padding(.top, 0).foregroundStyle(Color.gray)
            Spacer()
            NavigationLink( destination: ContentView()) {
                Text("Continuar").foregroundStyle(.white).padding(.horizontal, 70).padding(.vertical, 18).background(buttonColor).cornerRadius(50).padding().bold()                }
            
        }.preferredColorScheme(isDarkMode ? .dark : .light)
    }
    
}


#Preview {
    OnBoardView()
}
