import SwiftUI

struct ContentView: View {
    
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                CalendarCarouselView()
                    .frame(height: 150)
                    .padding(.top)
                
                Spacer() 
            }
            .navigationTitle("MuscleApp")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    HStack {
                        Spacer()
                        
                        NavigationLink(destination: ConquestView()){
                            Image(systemName: "trophy").foregroundColor(.primary)
                        }
                        
                        NavigationLink(destination: ProfileView(isDarkMode: $isDarkMode)){
                            Image(systemName: "gearshape").foregroundColor(.primary)
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
            }
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}

#Preview {
    ContentView()
}
