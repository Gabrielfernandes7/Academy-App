import SwiftUI

struct ContentView: View {
    
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    
    var buttonColor: Color = Color(red: 36/255, green: 138/255, blue: 61/255) 
    
    var body: some View {
        NavigationStack {
            VStack {
                CalendarView()
                Spacer()
            }
            .padding(.top, 30)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    HStack {
                        NavigationLink(destination: ConquestView()) {
                            Image(systemName: "trophy")
                                .foregroundColor(buttonColor)
                        }.padding(6)
                        
                        NavigationLink(destination: ProfileView(isDarkMode: $isDarkMode)) {
                            Image(systemName: "gearshape.fill")
                                .foregroundColor(buttonColor)
                        }
                    }
                }
            }.navigationBarBackButtonHidden(true)
            .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}

#Preview {
    ContentView()
}
