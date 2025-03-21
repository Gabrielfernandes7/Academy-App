import SwiftUI

struct CalendarCarouselView: View {
    let days = Array(1...31)
    @State private var selectedDay: Int = Calendar.current.component(.day, from: Date())

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 35) {
                ForEach(days, id: \.self) { day in
                    Text("\(day)")
                        .font(.title3)
                        .frame(width: 65, height: 65)
                        .background(selectedDay == day ? Color.gray : Color.gray.opacity(0.2))
                        .foregroundColor(selectedDay == day ? .white : .primary)
                        .clipShape(RoundedRectangle(cornerRadius: 12)) // Retângulo arredondado
                        .onTapGesture {
                            withAnimation {
                                selectedDay = day
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
