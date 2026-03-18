//
//  HabitsView.swift
//  AURA
//
//  Track daily habits with streaks and progress visualization.
//

import SwiftUI

struct HabitsView: View {
    @State private var habits: [Habit] = Habit.sampleHabits
    @State private var selectedDate = Date()
    
    var body: some View {
        ZStack {
            Color.auraBackground.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    // Header
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Habits")
                            .font(.system(size: 40, weight: .bold, design: .rounded))
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [.auraGreen, .auraTeal],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                        
                        let completedToday = habits.filter { $0.isCompletedToday }.count
                        Text("\(completedToday) of \(habits.count) completed today")
                            .font(.subheadline)
                            .foregroundColor(.auraTextSecondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    
                    // Habits Grid
                    LazyVGrid(
                        columns: [GridItem(.flexible()), GridItem(.flexible())],
                        spacing: 16
                    ) {
                        ForEach(habits.indices, id: \.self) { index in
                            HabitCard(habit: $habits[index])
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 100)
                }
            }
        }
    }
}

struct HabitCard: View {
    @Binding var habit: Habit
    @State private var showingDetail = false
    
    var body: some View {
        VStack(spacing: 16) {
            // Icon
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [habitColor.opacity(0.3), habitColor.opacity(0.1)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 64, height: 64)
                
                Image(systemName: habit.icon)
                    .font(.system(size: 28))
                    .foregroundColor(habitColor)
            }
            
            // Name
            Text(habit.name)
                .font(.system(size: 16, weight: .semibold, design: .rounded))
                .foregroundColor(.auraTextPrimary)
                .multilineTextAlignment(.center)
                .lineLimit(2)
            
            // Streak
            VStack(spacing: 4) {
                HStack(spacing: 4) {
                    Image(systemName: "flame.fill")
                        .font(.caption)
                    Text("\(habit.streakCount)")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                }
                .foregroundColor(.auraOrange)
                
                Text("day streak")
                    .font(.caption2)
                    .foregroundColor(.auraTextSecondary)
            }
            
            // Progress Ring
            ZStack {
                Circle()
                    .stroke(Color.auraCard, lineWidth: 4)
                    .frame(width: 50, height: 50)
                
                Circle()
                    .trim(from: 0, to: habit.completionRateThisWeek)
                    .stroke(
                        habitColor,
                        style: StrokeStyle(lineWidth: 4, lineCap: .round)
                    )
                    .frame(width: 50, height: 50)
                    .rotationEffect(.degrees(-90))
                
                Text("\(Int(habit.completionRateThisWeek * 100))%")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(habitColor)
            }
            
            // Check Button
            Button {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                    toggleHabitCompletion()
                }
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(
                            habit.isCompletedToday
                            ? LinearGradient(
                                colors: [habitColor.opacity(0.8), habitColor],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                            : LinearGradient(
                                colors: [Color.auraCard, Color.auraCard],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .frame(height: 44)
                    
                    HStack(spacing: 6) {
                        Image(systemName: habit.isCompletedToday ? "checkmark.circle.fill" : "circle")
                            .font(.system(size: 18))
                        Text(habit.isCompletedToday ? "Done" : "Mark Done")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(habit.isCompletedToday ? .white : .auraTextSecondary)
                }
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(Color.auraCard)
                .overlay(
                    RoundedRectangle(cornerRadius: 24)
                        .stroke(habit.isCompletedToday ? habitColor.opacity(0.5) : Color.auraCardBorder, lineWidth: habit.isCompletedToday ? 2 : 1)
                )
        )
    }
    
    var habitColor: Color {
        switch habit.color.lowercased() {
        case "purple": return .auraPurple
        case "green": return .auraGreen
        case "blue": return .auraBlue
        case "orange": return .auraOrange
        case "teal": return .auraTeal
        case "yellow": return .auraYellow
        case "pink": return .auraPink
        default: return .auraPurple
        }
    }
    
    func toggleHabitCompletion() {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        
        if habit.isCompletedToday {
            habit.completionDates.removeAll { calendar.isDate($0, inSameDayAs: today) }
        } else {
            habit.completionDates.append(today)
            
            // Update streak
            let sortedDates = habit.completionDates.sorted()
            var streak = 1
            var currentDate = today
            
            for date in sortedDates.reversed() {
                if calendar.isDate(date, inSameDayAs: currentDate) {
                    continue
                } else if let previousDay = calendar.date(byAdding: .day, value: -1, to: currentDate),
                          calendar.isDate(date, inSameDayAs: previousDay) {
                    streak += 1
                    currentDate = previousDay
                } else {
                    break
                }
            }
            habit.streakCount = streak
        }
    }
}

#Preview {
    HabitsView()
}
