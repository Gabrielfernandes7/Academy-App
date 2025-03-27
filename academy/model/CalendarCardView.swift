import SwiftUI
import SwiftData

struct CalendarView: View {
    @State private var currentDate: Date = .init()
    @State private var weekSlider: [[Date]] = []
    @State private var currentWeekIndex: Int = 1
    @State private var selectedDayType: DayType = .today
    @State var addWorkout: Bool = false
    @Query var workouts: [WorkoutModel]
    
    var buttonColor: Color = Color(red: 36/255, green: 138/255, blue: 61/255)
    let dayColor = Color(red: 255/255, green: 212/255, blue: 38/255)
    
    enum DayType {
        case today, past, future
    }
    
    var body: some View {
        VStack {
            headerView()
            
            TabView(selection: $currentWeekIndex) {
                ForEach(weekSlider.indices, id: \.self) { index in
                    let week = weekSlider[index]
                    weekView(week)
                        .tag(index)
                }
            }
            .frame(height: 75)
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            workoutCards()
                .padding()
        }
        .onAppear {
            loadWorkouts()
            if weekSlider.isEmpty {
                let currentWeek = fetchWeek(from: Date())
                if let firstDate = currentWeek.first {
                    weekSlider.append(createPreviousWeek(from: firstDate))
                }
                weekSlider.append(currentWeek)
                if let lastDate = currentWeek.last {
                    weekSlider.append(createNextWeek(from: lastDate))
                }
            }
        }
    }
    
    @ViewBuilder
    func headerView() -> some View {
        HStack {
            VStack(alignment:.leading) {
                HStack {
                    Text("Meus treinos")
                        .font(.system(size: 40))
                        .bold()
                    Spacer()
                    Button {
                        addWorkout = true
                    } label: {
                        Image(systemName: "plus.square.fill")
                            .font(.system(size: 30))
                            .foregroundColor(buttonColor)
                    }
                    .sheet(isPresented: $addWorkout) {
                        AddWorkoutView().presentationDragIndicator(.visible)
                    }
                }
//                Text(formattedDate(currentDate))
//                    .font(.headline)
            }
            Spacer()
        }
        .padding(.leading, 20)
    }

    @ViewBuilder
    func workoutCards() -> some View {
        ScrollView {
            VStack(spacing: 15) {
                if workouts.isEmpty {
                    Text("Nenhum treino salvo.")
                        .font(.title2)
                        .foregroundColor(.gray)
                } else {
                    ForEach(workouts, id: \..title) { workout in
                        NavigationLink(destination: ExerciseView()) {
                            VStack(alignment: .leading) {
                                HStack {
                                    Image(workout.icon)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 70, height: 70)
                                        .foregroundColor(.blue)

                                    VStack(alignment: .leading) {
                                        Text(workout.title)
                                            .font(.headline)
                                            .bold()
                                        Text("\(workout.exercises.count) exercícios")
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }
                                    Spacer()
                                    Image(systemName: "chevron.right").foregroundStyle(buttonColor)
                                }
                                .padding(.trailing, 15)
                            }
                            .frame(maxWidth: .infinity)
                            .background(RoundedRectangle(cornerRadius: 15).fill(Color.primary.opacity(0.1)))
                            .padding(.horizontal)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
        }
    }

    func loadWorkouts() {
//        workouts = [
//            WorkoutModelJSON(title: "Treino A", icon: "dumbbell", exercises: []),
//            WorkoutModelJSON(title: "Treino B", icon: "flame.fill", exercises: [])
//        ]
        
    }

    @ViewBuilder
    func weekView(_ week: [Date]) -> some View {
        HStack {
            ForEach(week, id: \.self) { day in
                dayView(for: day)
            }
        }
    }

    @ViewBuilder
    func dayView(for day: Date) -> some View {
        VStack {
            Text(day.formatted(.dateTime.weekday().locale(Locale(identifier: "pt_BR"))).capitalized)
                .font(.caption)
                .foregroundStyle(day < Date() ? Color.white : (isSameDate(day, currentDate) ? Color.white : Color.primary))

            Text(day, format: .dateTime.day())
                .font(.title2)
                .bold()
                .foregroundStyle(day < Date() ? Color.white : (isSameDate(day, currentDate) ? Color.white : Color.primary))
        }
        .padding(8)
        .background {
            dayBackground(for: day)
        }
        .onTapGesture {
            currentDate = day
            if isSameDate(day, Date()) {
                selectedDayType = .today
            } else if day < Date() {
                selectedDayType = .past
            } else {
                selectedDayType = .future
            }
        }
    }



    

    
    

    func dayBackground(for day: Date) -> some View {
        Group {
            if isSameDate(day, currentDate) {
                Rectangle()
                    .fill(Color.black)
                    .cornerRadius(10)
            } else if Calendar.current.isDateInToday(day) {
                Rectangle()
                    .fill(dayColor)
                    .cornerRadius(10)
            } else if day < Date() {
                Rectangle()
                    .fill(buttonColor)
                    .cornerRadius(10)
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .cornerRadius(10)
            }
        }
    }


    func fetchWeek(from date: Date) -> [Date] {
        let calendar = Calendar.current
        let startOfWeek = calendar.dateInterval(of: .weekOfYear, for: date)?.start ?? date
        return (0..<7).compactMap { calendar.date(byAdding: .day, value: $0, to: startOfWeek) }
    }

    func createPreviousWeek(from date: Date) -> [Date] {
        let calendar = Calendar.current
        return (1...7).compactMap { calendar.date(byAdding: .day, value: -$0, to: date) }.reversed()
    }

    func createNextWeek(from date: Date) -> [Date] {
        let calendar = Calendar.current
        return (1...7).compactMap { calendar.date(byAdding: .day, value: $0, to: date) }
    }

    func isSameDate(_ date1: Date, _ date2: Date) -> Bool {
        Calendar.current.isDate(date1, inSameDayAs: date2)
    }

    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        formatter.locale = Locale(identifier: "pt_BR")
        return formatter.string(from: date)
    }
}

#Preview {
    CalendarView()
        .modelContainer(for: [WorkoutModel.self, Exercise.self])
}
