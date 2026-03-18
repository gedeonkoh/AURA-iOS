# ✨ AURA - iOS Productivity App

![Swift](https://img.shields.io/badge/Swift-5.9-orange.svg)
![Platform](https://img.shields.io/badge/Platform-iOS%2017%2B-blue.svg)
![License](https://img.shields.io/badge/License-MIT-green.svg)

**AURA** - A reimagined productivity OS for iPhone. Liquid glass UI, focus flows, micro-animations, habit tracking & deep work sessions. Built with SwiftUI.

> *"Design so genius it feels illegal"* - Built for those cool iPhone apps you cannot live without

---

## 🌟 Features

### 📝 Smart Tasks
- **Energy-Based Prioritization** - Match tasks to your energy levels
- **Category Organization** - Personal, Work, Health, Creative, Learning, Finance
- **Priority System** - Low, Medium, High, Urgent with color-coded badges
- **Due Date Tracking** - Never miss a deadline
- **Beautiful Cards** - Liquid glass aesthetic with smooth animations

### 🔥 Habit Tracking
- **Streak System** - Build momentum with visual flame indicators
- **Progress Rings** - Weekly completion rate visualization
- **Grid Layout** - Beautiful 2-column card design
- **6 Pre-configured Habits**:
  - Morning Meditation (Mindfulness)
  - 10k Steps (Fitness)
  - Read 30 min (Learning)
  - No Phone Before 9am (Mindfulness)
  - Cold Shower (Fitness)
  - Journal (Mindfulness)

### ⏱️ Focus Timer
- **4 Session Types**:
  - **Deep Work** - 90 minutes of uninterrupted flow
  - **Pomodoro** - 25-minute focused sprints
  - **Sprint** - 15-minute quick sessions
  - **Flow** - 60-minute balanced focus
- **Circular Progress** - Mesmerizing gradient animations
- **Timer Controls** - Play, Pause, Reset with liquid glass buttons

### 🎨 Design System
- **Liquid Glass Morphism** - Translucent cards with subtle borders
- **Gradient Mastery** - Dynamic color transitions
- **Micro-Animations** - Spring physics and smooth transitions
- **Dark Theme** - Cosmic background (#0F0F19)
- **Custom Color Palette**:
  - Aurora Green (#33E69A)
  - Cosmic Blue (#4D99FF)
  - Nebula Purple (#B34DFF)
  - Solar Orange (#FFC299)
  - Star Yellow (#FFE633)
  - Galaxy Teal (#33CCCC)
  - Nova Pink (#FF4D99)

---

## 📱 Screenshots

### Main Navigation
![AURA Main](screenshots/main-nav.png)
*Liquid glass navigation with animated tab bar*

### Tasks View
![Tasks](screenshots/tasks.png)
*Energy-based task management with category filters*

### Habits Grid
![Habits](screenshots/habits.png)
*Beautiful habit cards with streaks and progress rings*

### Focus Timer
![Focus](screenshots/focus.png)
*Mesmerizing circular timer with gradient animations*

---

## 🏗️ Architecture

```
AURA-iOS/
├── AURA.xcodeproj/          # Xcode project file
│   └── project.pbxproj       # Project configuration
├── AURA/                     # Main app directory
│   ├── App.swift             # App entry point
│   ├── ContentView.swift     # Main navigation & tab bar
│   ├── Models.swift          # Data models (Task, Habit, FocusSession, UserProfile)
│   ├── TasksView.swift       # Task management interface
│   ├── HabitsView.swift      # Habit tracking with streaks
│   ├── FocusView.swift       # Deep focus timer
│   ├── Info.plist            # App configuration
│   └── Assets.xcassets/      # App icons & colors
│       ├── AppIcon.appiconset/
│       ├── AccentColor.colorset/
│       └── Contents.json
├── README.md                 # This file
└── SETUP.md                  # Installation guide
```

### Key Models

**AuraTask**
- Title, notes, completion status
- Priority levels (Low, Medium, High, Urgent)
- Categories (Personal, Work, Health, Creative, Learning, Finance)
- Energy level (1-5)
- Due dates and creation timestamps

**Habit**
- Name, icon, color
- Completion dates array
- Streak counter
- Target days per week
- Weekly completion rate calculation

**FocusSession**
- Session types (Deep Work, Pomodoro, Sprint, Flow)
- Duration tracking
- XP rewards system

**UserProfile**
- Level and XP progression
- Total focus minutes
- Tasks completed
- Current & longest streaks

---

## 🚀 Getting Started

### Prerequisites
- **Xcode 15+** (for iOS 17+ support)
- **macOS 13+** (Ventura or later)
- **Apple Developer Account** (for device deployment)

### Quick Setup

1. **Clone the Repository**
```bash
git clone https://github.com/gedeonkoh/AURA-iOS.git
cd AURA-iOS
```

2. **Open in Xcode**
```bash
open AURA.xcodeproj
```

3. **Select Target Device**
   - Choose an iPhone simulator (iPhone 15 Pro recommended)
   - Or connect your physical iPhone

4. **Build & Run**
   - Press `Cmd + R` or click the Play button
   - Wait for build to complete
   - App launches on simulator/device

### Detailed Setup

See [SETUP.md](SETUP.md) for comprehensive installation instructions, troubleshooting, and deployment guides.

---

## 💻 Tech Stack

- **Language**: Swift 5.9+
- **Framework**: SwiftUI
- **Minimum iOS**: 17.0
- **Architecture**: MVVM with @State management
- **Design**: Custom liquid glass morphism
- **Animations**: Spring physics, gradient transitions
- **Storage**: In-memory (easily expandable to CoreData/SwiftData)

---

## 🎯 Roadmap

### Phase 1 (Current) ✅
- [x] Core UI/UX with liquid glass design
- [x] Task management with energy levels
- [x] Habit tracking with streaks
- [x] Focus timer with 4 session types
- [x] Beautiful animations

### Phase 2 (Coming Soon)
- [ ] Data persistence (CoreData/SwiftData)
- [ ] Notifications & reminders
- [ ] Widgets (Lock Screen & Home Screen)
- [ ] iCloud sync
- [ ] Advanced analytics & insights
- [ ] Themes customization

### Phase 3 (Future)
- [ ] Apple Watch companion app
- [ ] Siri Shortcuts integration
- [ ] Collaborative habits
- [ ] AI-powered task suggestions
- [ ] Export & backup features

---

## 🎨 Design Philosophy

**Liquid Glass Aesthetic**
- Translucent backgrounds with subtle borders
- Gradient overlays that shift with interaction
- Depth through layering and shadows

**Micro-Animations**
- Spring physics (response: 0.3-0.4, damping: 0.6)
- Smooth state transitions
- Delightful feedback on every interaction

**Minimalist Yet Feature-Rich**
- Clean, uncluttered interfaces
- Information hierarchy through typography
- Purposeful use of color

---

## 🤝 Contributing

Contributions are welcome! Whether you're fixing bugs, improving documentation, or proposing new features.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

---

## 👤 Author

**Gedeon Koh**
- GitHub: [@gedeonkoh](https://github.com/gedeonkoh)

---

## 🙏 Acknowledgments

- Inspired by minimalist productivity apps and iOS design trends 2025/2026
- Liquid glass design influenced by glassmorphism and neomorphism trends
- Special thanks to the SwiftUI community

---

## 📧 Contact

Have questions or feedback? Open an issue or reach out!

---

**Built with ❤️ and SwiftUI**
