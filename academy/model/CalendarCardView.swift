import SwiftUI

struct CalendarCarouselView: View {
    let days = Array(1...31)
    @State private var selectedDay: Int = Calendar.current.component(.day, from: Date())
    
    // Definindo os nomes dos dias da semana em português (pt-BR)
    private let weekdaySymbols = [
        "Dom", "Seg", "Ter", "Qua", "Qui", "Sex", "Sáb"
    ]
    
    // Forçando o uso da localidade pt-BR para o nome do mês
    private var currentMonth: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.dateFormat = "MMMM"
        return formatter.string(from: Date())
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 30) {
                ForEach(days, id: \.self) { day in
                    VStack {
                        // Criando uma data para o dia específico
                        let date = Calendar.current.date(bySetting: .day, value: day, of: Date())!
                        
                        // Obtendo o nome do dia da semana
                        let weekdayIndex = Calendar.current.component(.weekday, from: date) - 1
                        let weekdayName = weekdaySymbols[weekdayIndex]
                        
                        // Card do dia com nome do dia, número e mês
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(selectedDay == day ? Color.gray : Color.gray.opacity(0.2))
                                .frame(width: 70, height: 75)
                            
                            VStack {
                                Text(weekdayName)
                                    .font(.footnote)
                                    .foregroundColor(.secondary)
                                
                                Text("\(day)")
                                    .font(.title3)
                                    .foregroundColor(selectedDay == day ? .white : .primary)
                                
                                Text(currentMonth)
                                    .font(.footnote)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .onTapGesture {
                            withAnimation {
                                selectedDay = day
                            }
                        }
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    CalendarCarouselView()
}
