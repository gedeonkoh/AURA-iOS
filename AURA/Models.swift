//
//  Models.swift
//  AURA
//
//  The data layer for AURA productivity app.
//

import Foundation
import SwiftUI

// MARK: - Task Model

struct AuraTask: Identifiable, Codable {
    var id = UUID()
    var title: String
    var notes: String
    var isCompleted: Bool
    var priority: TaskPriority
    var dueDate: Date?
    var category: TaskCategory
    var createdAt: Date
    var completedAt: Date?
    var energyLevel: Int // 1-5
    
    enum TaskPriority: String, Codable, CaseIterable {
        case low = "Low"
        case medium = "Medium"
        case high = "High"
        case urgent = "Urgent"
        
        var color: Color {
            switch self {
            case .low: return .auraGreen
            case .medium: return .auraBlue
            case .high: return .auraOrange
            case .urgent: return .auraPurple
            }
        }
        
        var icon: String {
            switch self {
            case .low: return "arrow.down"
            case .medium: return "minus"
            case .high: return "arrow.up"
            case .urgent: return "bolt.fill"
            }
        }
    }
    
    enum TaskCategory: String, Codable, CaseIterable {
        case personal = "Personal"
        case work = "Work"
        case health = "Health"
        case creative = "Creative"
        case learning = "Learning"
        case finance = "Finance"
        
        var icon: String {
            switch self {
            case .personal: return "person.fill"
            case .work: return "briefcase.fill"
            case .health: return "heart.fill"
            case .creative: return "paintbrush.fill"
            case .learning: return "book.fill"
            case .finance: return "dollarsign.circle.fill"
            }
        }
        
        var color: Color {
            switch self {
            case .personal: return .auraBlue
            case .work: return .auraPurple
            case .health: return .auraGreen
            case .creative: return .auraOrange
            case .learning: return .auraYellow
            case .finance: return .auraTeal
            }
        }
    }
    
    init(title: String, notes: String = "", priority: TaskPriority = .medium, dueDate: Date? = nil, category: TaskCategory = .personal, energyLevel: Int = 3) {
        self.title = title
        self.notes = notes
        self.isCompleted = false
        self.priority = priority
        self.dueDate = dueDate
        self.category = category
        self.createdAt = Date()
        self.energyLevel = energyLevel
    }
}

// MARK: - Habit Model

struct Habit: Identifiable, Codable {
    var id = UUID()
    var name: String
    var icon: String
    var color: String
    var completionDates: [Date]
    var streakCount: Int
    var targetDaysPerWeek: Int
    var reminderTime: Date?
    var category: HabitCategory
    var createdAt: Date
    
    enum HabitCategory: String, Codable, CaseIterable {
        case mindfulness = "Mindfulness"
        case fitness = "Fitness"
        case nutrition = "Nutrition"
        case learning = "Learning"
        case social = "Social"
        case sleep = "Sleep"
        
        var icon: String {
            switch self {
            case .mindfulness: return "brain.head.profile"
            case .fitness: return "figure.run"
            case .nutrition: return "leaf.fill"
            case .learning: return "book.closed.fill"
            case .social: return "person.2.fill"
            case .sleep: return "moon.stars.fill"
            }
        }
    }
    
    var isCompletedToday: Bool {
        let calendar = Calendar.current
        return completionDates.contains { calendar.isDateInToday($0) }
    }
    
    var completionRateThisWeek: Double {
        let calendar = Calendar.current
        let startOfWeek = calendar.dateInterval(of: .weekOfYear, for: Date())?.start ?? Date()
        let completionsThisWeek = completionDates.filter { $0 >= startOfWeek }.count
        return Double(completionsThisWeek) / Double(targetDaysPerWeek)
    }
    
    init(name: String, icon: String, color: String, targetDaysPerWeek: Int = 7, category: HabitCategory = .mindfulness) {
        self.name = name
        self.icon = icon
        self.color = color
        self.completionDates = []
        self.streakCount = 0
        self.targetDaysPerWeek = targetDaysPerWeek
        self.category = category
        self.createdAt = Date()
    }
}

// MARK: - Focus Session Model

struct FocusSession: Identifiable, Codable {
    var id = UUID()
    var taskTitle: String
    var duration: TimeInterval // in seconds
    var completedDuration: TimeInterval
    var startedAt: Date
    var endedAt: Date?
    var sessionType: SessionType
    var xpEarned: Int
    
    enum SessionType: String, Codable, CaseIterable {
        case deepWork = "Deep Work"
        case pomodoro = "Pomodoro"
        case sprint = "Sprint"
        case flow = "Flow"
        
        var defaultDuration: TimeInterval {
            switch self {
            case .deepWork: return 90 * 60
            case .pomodoro: return 25 * 60
            case .sprint: return 15 * 60
            case .flow: return 60 * 60
            }
        }
        
        var icon: String {
            switch self {
            case .deepWork: return "brain"
            case .pomodoro: return "timer"
            case .sprint: return "bolt.fill"
            case .flow: return "water.waves"
            }
        }
    }
}

// MARK: - User Profile

struct UserProfile: Codable {
    var name: String
    var totalXP: Int
    var level: Int
    var totalFocusMinutes: Int
    var tasksCompleted: Int
    var currentStreak: Int
    var longestStreak: Int
    var joinDate: Date
    var preferredTheme: AppTheme
    
    enum AppTheme: String, Codable, CaseIterable {
        case cosmic = "Cosmic"
        case aurora = "Aurora"
        case midnight = "Midnight"
        case sage = "Sage"
    }
    
    var levelTitle: String {
        switch level {
        case 1...5: return "Wanderer"
        case 6...10: return "Seeker"
        case 11...20: return "Builder"
        case 21...35: return "Achiever"
        case 36...50: return "Master"
        default: return "Legend"
        }
    }
    
    var xpForNextLevel: Int {
        return level * 500
    }
    
    var xpProgress: Double {
        let currentLevelXP = (level - 1) * 500
        let neededXP = xpForNextLevel - currentLevelXP
        let earnedXP = totalXP - currentLevelXP
        return min(Double(earnedXP) / Double(neededXP), 1.0)
    }
    
    static var `default`: UserProfile {
        UserProfile(
            name: "Explorer",
            totalXP: 0,
            level: 1,
            totalFocusMinutes: 0,
            tasksCompleted: 0,
            currentStreak: 0,
            longestStreak: 0,
            joinDate: Date(),
            preferredTheme: .cosmic
        )
    }
}

// MARK: - Color Extensions

extension Color {
    static let auraGreen = Color(red: 0.2, green: 0.9, blue: 0.6)
    static let auraBlue = Color(red: 0.3, green: 0.6, blue: 1.0)
    static let auraPurple = Color(red: 0.7, green: 0.3, blue: 1.0)
    static let auraOrange = Color(red: 1.0, green: 0.6, blue: 0.2)
    static let auraYellow = Color(red: 1.0, green: 0.9, blue: 0.2)
    static let auraTeal = Color(red: 0.2, green: 0.8, blue: 0.8)
    static let auraPink = Color(red: 1.0, green: 0.3, blue: 0.6)
    
    static let auraBackground = Color(red: 0.06, green: 0.06, blue: 0.10)
    static let auraCard = Color(red: 0.12, green: 0.12, blue: 0.18)
    static let auraCardBorder = Color(white: 1.0, opacity: 0.08)
    static let auraTextPrimary = Color(white: 0.95)
    static let auraTextSecondary = Color(white: 0.6)
}

// MARK: - Sample Data

extension AuraTask {
    static var sampleTasks: [AuraTask] {
        [
            AuraTask(title: "Design app mockups", notes: "Focus on the onboarding flow", priority: .high, category: .creative, energyLevel: 4),
            AuraTask(title: "Review quarterly goals", notes: "", priority: .urgent, dueDate: Calendar.current.date(byAdding: .day, value: 1, to: Date()), category: .work, energyLevel: 3),
            AuraTask(title: "Morning meditation", notes: "10 minutes minimum", priority: .medium, category: .health, energyLevel: 2),
            AuraTask(title: "Read 30 pages", notes: "Currently: Atomic Habits", priority: .low, category: .learning, energyLevel: 2),
            AuraTask(title: "Weekly budget review", notes: "", priority: .medium, dueDate: Calendar.current.date(byAdding: .day, value: 3, to: Date()), category: .finance, energyLevel: 3)
        ]
    }
}

extension Habit {
    static var sampleHabits: [Habit] {
        [
            Habit(name: "Morning Meditation", icon: "brain.head.profile", color: "purple", targetDaysPerWeek: 7, category: .mindfulness),
            Habit(name: "10k Steps", icon: "figure.walk", color: "green", targetDaysPerWeek: 5, category: .fitness),
            Habit(name: "Read 30 min", icon: "book.closed.fill", color: "blue", targetDaysPerWeek: 7, category: .learning),
            Habit(name: "No Phone Before 9am", icon: "iphone.slash", color: "orange", targetDaysPerWeek: 7, category: .mindfulness),
            Habit(name: "Cold Shower", icon: "drop.fill", color: "teal", targetDaysPerWeek: 5, category: .fitness),
            Habit(name: "Journal", icon: "pencil.and.list.clipboard", color: "yellow", targetDaysPerWeek: 7, category: .mindfulness)
        ]
    }
}
