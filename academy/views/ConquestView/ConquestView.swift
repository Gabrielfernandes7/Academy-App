import SwiftUI

struct ConquestView: View {
    
    @State private var progress = 75.0

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
                        .padding(.horizontal, 0)
                        .frame(height: 10)
                    Text("4")
                }
                .padding(.top, 40)

                Text("Prodígio iniciante")
                    .font(.title2)
                    .padding(.top)

                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    ConquestView()
}
