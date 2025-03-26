import SwiftUI

struct ContentView: View {
    
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    

    var body: some View {
        NavigationStack {
            VStack {
                CalendarView()
                
                Spacer()
            }.padding(.top, 30)
//            .navigationTitle("Meus treinos")
            .toolbar {

                ToolbarItem(placement: .topBarTrailing) {
                    HStack {
                        NavigationLink(destination: ConquestView()) {
                            Image(systemName: "trophy").foregroundColor(.primary)
                        }.padding(6)
                        
                        NavigationLink(destination: ProfileView(isDarkMode: $isDarkMode)) {
                            Image(systemName: "gearshape.fill").foregroundColor(.primary)
                        }
                    }
                }
            }
            .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}

#Preview {
    ContentView()
}
