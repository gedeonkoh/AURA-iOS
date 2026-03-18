import SwiftUI

struct ContentView: View {
    @State private var time = Date()
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var isFocusing = false
    @State private var focusTime: CGFloat = 0
    
    var body: some View {
        ZStack {
            // Background Liquid Mesh Gradient
            MeshGradientView()
                .ignoresSafeArea()
            
            VStack(spacing: 40) {
                // Header
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(time, style: .time)
                            .font(.system(size: 34, weight: .bold, design: .rounded))
                        Text(time.formatted(date: .abbreviated, time: .omitted))
                            .font(.system(size: 16, weight: .medium, design: .rounded))
                            .opacity(0.6)
                    }
                    Spacer()
                    Circle()
                        .fill(.ultraThinMaterial)
                        .frame(width: 44, height: 44)
                        .overlay(Image(systemName: "person.fill").foregroundStyle(.secondary))
                }
                .padding(.horizontal, 24)
                
                // Focus Card
                VStack(spacing: 20) {
                    Text(isFocusing ? "DEEP FLOW" : "AURA STATUS")
                        .font(.system(size: 12, weight: .bold))
                        .kerning(2)
                        .foregroundStyle(.secondary)
                    
                    ZStack {
                        Circle()
                            .stroke(.white.opacity(0.1), lineWidth: 20)
                        
                        Circle()
                            .trim(from: 0, to: isFocusing ? focusTime : 0.7)
                            .stroke(
                                LinearGradient(colors: [.blue, .purple, .pink], startPoint: .topLeading, endPoint: .bottomTrailing),
                                style: StrokeStyle(lineWidth: 20, lineCap: .round)
                            )
                            .rotationEffect(.degrees(-90))
                            .animation(.easeInOut(duration: 2), value: focusTime)
                        
                        VStack {
                            Text(isFocusing ? "24:12" : "READY")
                                .font(.system(size: 48, weight: .black, design: .rounded))
                            Text(isFocusing ? "until completion" : "tap to enter flow")
                                .font(.caption)
                                .opacity(0.5)
                        }
                    }
                    .frame(width: 250, height: 250)
                    .shadow(color: .purple.opacity(0.3), radius: 30)
                }
                .padding(40)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 50, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: 50, style: .continuous)
                        .stroke(.white.opacity(0.2), lineWidth: 1)
                )
                .padding(.horizontal, 24)
                
                // Stacked Features (Minimalist Grid)
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                    FeatureCard(icon: "bolt.fill", title: "Energy", value: "88%", color: .orange)
                    FeatureCard(icon: "leaf.fill", title: "Zen", value: "12m", color: .green)
                    FeatureCard(icon: "brain.head.profile", title: "IQ Shift", value: "+2.4", color: .blue)
                    FeatureCard(icon: "sparkles", title: "Aura", value: "Gold", color: .yellow)
                }
                .padding(.horizontal, 24)
                
                Spacer()
                
                // Action Button
                Button {
                    withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
                        isFocusing.toggle()
                        if isFocusing { focusTime = 0.9 }
                    }
                } label: {
                    Text(isFocusing ? "EXIT FLOW" : "START SESSION")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 64)
                        .background(isFocusing ? AnyShapeStyle(.red.opacity(0.5)) : AnyShapeStyle(.black))
                        .clipShape(Capsule())
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 20)
            }
        }
        .onReceive(timer) { input in
            time = input
        }
    }
}

struct FeatureCard: View {
    let icon: String
    let title: String
    let value: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundStyle(color)
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.caption)
                    .opacity(0.6)
                Text(value)
                    .font(.headline)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(20)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .stroke(.white.opacity(0.1), lineWidth: 1)
        )
    }
}

struct MeshGradientView: View {
    @State private var t: CGFloat = 0
    
    var body: some View {
        TimelineView(.animation) { timeline in
            Canvas { context, size in
                // Custom shader-like liquid background simulation
                // In a real app we'd use a Metal shader or MeshGradient (iOS 18)
                context.fill(Path(CGRect(origin: .zero, size: size)), with: .color(.black))
                
                for i in 0..<5 {
                    let x = size.width * (0.5 + 0.3 * sin(t + CGFloat(i)))
                    let y = size.height * (0.5 + 0.3 * cos(t * 0.8 + CGFloat(i)))
                    let radius = size.width * 0.8
                    
                    context.fill(
                        Path(ellipseIn: CGRect(x: x - radius/2, y: y - radius/2, width: radius, height: radius)),
                        with: .radialGradient(
                            Gradient(colors: [
                                Color(hue: Double(i) * 0.2, saturation: 0.6, brightness: 0.4).opacity(0.3),
                                .clear
                            ]),
                            center: CGPoint(x: x, y: y),
                            startRadius: 0,
                            endRadius: radius/2
                        )
                    )
                }
            }
            .onAppear {
                withAnimation(.linear(duration: 20).repeatForever(autoreverses: false)) {
                    t = 2 * .pi
                }
            }
        }
    }
}
