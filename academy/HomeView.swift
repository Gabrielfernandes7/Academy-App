import SwiftUI

struct HomeView: View {
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
                        Text("Treinos")
                            .font(.system(size: 30))
                        Spacer()
                        Button(action: {
                            // Ação do botão
                            print("Botão de adicionar pressionado")
                        }) {
                            Image(systemName: "plus")
                                .foregroundColor(.white)
                                .padding(10)
                                .background(Color.blue)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            Image(systemName: "list.star")
                                .foregroundColor(.white)
                                .padding(10)
                                .background(Color.blue)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    }
                    .frame(maxWidth: .infinity) // Ocupa toda a largura disponível
                }
            }
        }
    }
}

#Preview {
    HomeView()
}

