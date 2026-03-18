//
//  FocusView.swift
//  AURA
//
//  Deep focus timer with liquid glass aesthetic.
//

import SwiftUI

struct FocusView: View {
    @State private var selectedSessionType: FocusSession.SessionType = .deepWork
    @State private var isTimerRunning = false
    @State private var timeRemaining: TimeInterval = 90 * 60
    @State private var totalDuration: TimeInterval = 90 * 60
    
    var progress: Double {
        guard totalDuration > 0 else { return 0 }
        return 1.0 - (timeRemaining / totalDuration)
    }
    
    var body: some View {
        ZStack {
            Color.auraBackground.ignoresSafeArea()
            
            VStack(spacing: 40) {
                // Header
                Text("Focus")
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.auraOrange, .auraPink],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                
                Spacer()
                
                // Timer Circle
                ZStack {
                    // Background Circle
                    Circle()
                        .stroke(
                            LinearGradient(
                                colors: [Color.auraCard, Color.auraCard.opacity(0.5)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 20
                        )
                    
                    // Progress Circle
                    Circle()
                        .trim(from: 0, to: progress)
                        .stroke(
                            LinearGradient(
                                colors: [.auraOrange, .auraPink, .auraPurple],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            style: StrokeStyle(lineWidth: 20, lineCap: .round)
                        )
                        .rotationEffect(.degrees(-90))
                        .shadow(color: .auraOrange.opacity(0.5), radius: 20, x: 0, y: 0)
                    
                    // Time Display
                    VStack(spacing: 12) {
                        Text(timeString)
                            .font(.system(size: 64, weight: .bold, design: .rounded))
                            .foregroundColor(.auraTextPrimary)
                        
                        Text(selectedSessionType.rawValue)
                            .font(.headline)
                            .foregroundColor(.auraTextSecondary)
                    }
                }
                .frame(width: 280, height: 280)
                .padding(40)
                
                // Session Type Selector
                HStack(spacing: 12) {
                    ForEach(FocusSession.SessionType.allCases, id: \.self) { type in
                        SessionTypeButton(
                            type: type,
                            isSelected: selectedSessionType == type
                        ) {
                            selectedSessionType = type
                            totalDuration = type.defaultDuration
                            timeRemaining = type.defaultDuration
                        }
                    }
                }
                .padding(.horizontal, 20)
                
                // Control Buttons
                HStack(spacing: 20) {
                    // Reset Button
                    Button {
                        timeRemaining = totalDuration
                        isTimerRunning = false
                    } label: {
                        Image(systemName: "arrow.counterclockwise")
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundColor(.auraTextSecondary)
                            .frame(width: 64, height: 64)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.auraCard)
                            )
                    }
                    
                    // Play/Pause Button
                    Button {
                        isTimerRunning.toggle()
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 24)
                                .fill(
                                    LinearGradient(
                                        colors: [.auraOrange, .auraPink],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .shadow(color: .auraOrange.opacity(0.5), radius: 20, x: 0, y: 10)
                            
                            Image(systemName: isTimerRunning ? "pause.fill" : "play.fill")
                                .font(.system(size: 32, weight: .semibold))
                                .foregroundColor(.white)
                        }
                        .frame(width: 200, height: 64)
                    }
                }
                .padding(.horizontal, 20)
                
                Spacer()
            }
        }
    }
    
    var timeString: String {
        let minutes = Int(timeRemaining) / 60
        let seconds = Int(timeRemaining) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

struct SessionTypeButton: View {
    let type: FocusSession.SessionType
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Image(systemName: type.icon)
                    .font(.title2)
                Text(type.rawValue)
                    .font(.caption)
                    .fontWeight(.semibold)
            }
            .foregroundColor(isSelected ? .white : .auraTextSecondary)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(
                        isSelected
                        ? LinearGradient(
                            colors: [.auraOrange.opacity(0.8), .auraPink.opacity(0.8)],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        : LinearGradient(
                            colors: [Color.auraCard, Color.auraCard],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(isSelected ? Color.clear : Color.auraCardBorder, lineWidth: 1)
            )
        }
    }
}

#Preview {
    FocusView()
}
