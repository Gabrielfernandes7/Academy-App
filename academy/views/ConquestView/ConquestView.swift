import SwiftUI

struct ConquestView: View {
    
    @State private var progress = 75.0
    var buttonColor: Color = Color(red: 36/255, green: 138/255, blue: 61/255)

    var body: some View {
        NavigationStack {
            VStack {
                Text("Conquistas")
                    .font(.largeTitle)
                    .padding(.bottom)
                
                HStack {
                    Text("3")
                    ProgressView(value: progress, total: 100)
                        .progressViewStyle(LinearProgressViewStyle())
                        .accentColor(buttonColor) // Aqui definimos a cor da barra de progresso
                        .padding(.horizontal, 0)
                        .frame(height: 10)
                    Text("4")
                }
                .padding(.top, 40)

                Text("Prodígio iniciante")
                    .font(.title2)
                    .padding(.top)
                    .foregroundStyle(buttonColor)

                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    ConquestView()
}
