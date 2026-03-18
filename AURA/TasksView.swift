//
//  TasksView.swift
//  AURA
//
//  Beautiful task management with energy-based productivity.
//

import SwiftUI

struct TasksView: View {
    @State private var tasks: [AuraTask] = AuraTask.sampleTasks
    @State private var showingAddTask = false
    @State private var filterCategory: AuraTask.TaskCategory?
    
    var filteredTasks: [AuraTask] {
        if let category = filterCategory {
            return tasks.filter { $0.category == category }
        }
        return tasks
    }
    
    var body: some View {
        ZStack {
            Color.auraBackground.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    // Header
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Tasks")
                            .font(.system(size: 40, weight: .bold, design: .rounded))
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [.auraBlue, .auraPurple],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                        
                        Text("\(tasks.filter { !$0.isCompleted }.count) active · \(tasks.filter { $0.isCompleted }.count) completed")
                            .font(.subheadline)
                            .foregroundColor(.auraTextSecondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    
                    // Category Filter
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            CategoryFilterChip(category: nil, selectedCategory: $filterCategory, label: "All")
                            
                            ForEach(AuraTask.TaskCategory.allCases, id: \.self) { category in
                                CategoryFilterChip(category: category, selectedCategory: $filterCategory, label: category.rawValue)
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                    
                    // Tasks List
                    LazyVStack(spacing: 16) {
                        ForEach(filteredTasks.indices, id: \.self) { index in
                            TaskCard(task: $tasks[index])
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 100)
                }
            }
            
            // Floating Add Button
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button {
                        showingAddTask = true
                    } label: {
                        ZStack {
                            Circle()
                                .fill(
                                    LinearGradient(
                                        colors: [.auraPurple, .auraBlue],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .frame(width: 64, height: 64)
                                .shadow(color: .auraPurple.opacity(0.5), radius: 20, x: 0, y: 10)
                            
                            Image(systemName: "plus")
                                .font(.system(size: 28, weight: .semibold))
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.trailing, 20)
                    .padding(.bottom, 20)
                }
            }
        }
    }
}

struct TaskCard: View {
    @Binding var task: AuraTask
    @State private var showDetails = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                // Checkbox
                Button {
                    withAnimation(.spring(response: 0.3)) {
                        task.isCompleted.toggle()
                    }
                } label: {
                    ZStack {
                        Circle()
                            .stroke(task.priority.color, lineWidth: 2)
                            .frame(width: 28, height: 28)
                        
                        if task.isCompleted {
                            Circle()
                                .fill(task.priority.color)
                                .frame(width: 28, height: 28)
                            
                            Image(systemName: "checkmark")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(.auraBackground)
                        }
                    }
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(task.title)
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                        .foregroundColor(.auraTextPrimary)
                        .strikethrough(task.isCompleted)
                    
                    HStack(spacing: 8) {
                        Label(task.category.rawValue, systemImage: task.category.icon)
                            .font(.caption)
                            .foregroundColor(task.category.color)
                        
                        if let dueDate = task.dueDate {
                            Text("Due " + dueDate.formatted(date: .abbreviated, time: .omitted))
                                .font(.caption)
                                .foregroundColor(.auraTextSecondary)
                        }
                    }
                }
                
                Spacer()
                
                // Priority Badge
                HStack(spacing: 4) {
                    Image(systemName: task.priority.icon)
                        .font(.caption)
                    Text(task.priority.rawValue)
                        .font(.caption)
                        .fontWeight(.semibold)
                }
                .foregroundColor(task.priority.color)
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .background(
                    Capsule()
                        .fill(task.priority.color.opacity(0.15))
                )
            }
            
            if !task.notes.isEmpty {
                Text(task.notes)
                    .font(.caption)
                    .foregroundColor(.auraTextSecondary)
                    .lineLimit(2)
            }
            
            // Energy Level
            HStack(spacing: 4) {
                ForEach(1...5, id: \.self) { level in
                    Image(systemName: level <= task.energyLevel ? "bolt.fill" : "bolt")
                        .font(.caption2)
                        .foregroundColor(level <= task.energyLevel ? .auraYellow : .auraTextSecondary.opacity(0.3))
                }
                Text("Energy needed")
                    .font(.caption2)
                    .foregroundColor(.auraTextSecondary)
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.auraCard)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.auraCardBorder, lineWidth: 1)
                )
        )
        .opacity(task.isCompleted ? 0.6 : 1.0)
    }
}

struct CategoryFilterChip: View {
    let category: AuraTask.TaskCategory?
    @Binding var selectedCategory: AuraTask.TaskCategory?
    let label: String
    
    var isSelected: Bool {
        if let category = category {
            return selectedCategory == category
        }
        return selectedCategory == nil
    }
    
    var body: some View {
        Button {
            withAnimation(.spring(response: 0.3)) {
                selectedCategory = category
            }
        } label: {
            HStack(spacing: 6) {
                if let category = category {
                    Image(systemName: category.icon)
                        .font(.caption)
                }
                Text(label)
                    .font(.subheadline)
                    .fontWeight(.semibold)
            }
            .foregroundColor(isSelected ? .white : .auraTextSecondary)
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(
                Capsule()
                    .fill(
                        isSelected
                        ? LinearGradient(
                            colors: [category?.color ?? .auraPurple, .auraBlue],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                        : LinearGradient(
                            colors: [.auraCard, .auraCard],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
            )
            .overlay(
                Capsule()
                    .stroke(isSelected ? Color.clear : Color.auraCardBorder, lineWidth: 1)
            )
        }
    }
}

#Preview {
    TasksView()
}
