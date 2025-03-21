//
//  ProfileView.swift
//  ProjetoAcademy
//
//  Created by User on 18/03/25.
//

import SwiftUI

struct ProfileView: View {
    
    @Binding var isDarkMode: Bool
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        NavigationStack {
            
            Form {
                Section(header: Text("Aparência")) {
                    Toggle("Dark Mode", isOn: $isDarkMode)
                        .font(.system(size: 18)).onChange(of: isDarkMode) { _ in
                            UIApplication.shared.windows.first?.overrideUserInterfaceStyle = isDarkMode ? .dark : .light
                        }
                }
                Section(header: Text("Desenvolvedores")){
                    Link(destination: URL("https://google.com")!) {
                        HStack{
                            Image(systemName: "person.crop.circle").font(.system(size: 30))
                            Text("Gabriel Assunção")
                            
                            Spacer()
                            Image(systemName: "chevron.right")
                            
                        }.foregroundColor(.primary)
                    }
                    Link(destination: URL("https://google.com")!) {
                        HStack{
                            Image(systemName: "person.crop.circle").font(.system(size: 30))
                            Text("Wilson José")
                                .foregroundColor(.primary)
                            Spacer()
                            Image(systemName: "chevron.right")
                        }.foregroundColor(.primary)
                    }
                    Link(destination: URL("https://google.com")!) {
                        HStack{
                            Image(systemName: "person.crop.circle").font(.system(size: 30))
                            Text("Yuri Elias")
                                .foregroundColor(.primary)
                            Spacer()
                            Image(systemName: "chevron.right")
                            
                        }.foregroundColor(.primary)
                    }
                }
                
                Section(header: Text("Está curtindo o aplicativo?")){
                    Link(destination: URL("google.com")!) {
                        HStack{
                            Image(systemName: "star").font(.system(size: 20))
                            Text("Avalie na App Store")
                            
                            
                        }.foregroundColor(.primary)
                    }
                }
            }
            .preferredColorScheme(isDarkMode ? .dark : .light)
            .navigationTitle(Text("Configurações"))
            
            
            
        }
    }    }


#Preview {
    ProfileView(isDarkMode: .constant(false))
}
