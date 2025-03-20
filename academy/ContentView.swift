import SwiftUI

struct ContentView: View {

    var body: some View {
        NavigationView {
            List {
                Section {
                    // Calendários
                    Text("Local do calendário")
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // Item centralizado (título + botão)
                ToolbarItem(placement: .principal) {
                    HStack {
                        Text("Nome do App")
                            .font(.system(size: 30))
                        Spacer()
                        
                        Button(action: {
                            // Ação do botão
                            print("Botão de conquistas pressionado")
                        }) {
                            Image(systemName: "trophy").foregroundStyle(.black)
                            
                            
                        }
                        
                        Button(action: {
                            // Ação do botão
                            print("Botão de settings pressionado")
                        }) {
                            Image(systemName: "gearshape.fill").foregroundStyle(.black)
                        }
                    }
                    .frame(maxWidth: .infinity) // Ocupa toda a largura disponível
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

