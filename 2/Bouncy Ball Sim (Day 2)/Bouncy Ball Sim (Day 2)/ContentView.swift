//
//  ContentView.swift
//  Bouncy Ball Sim (Day 2)
//
//  Created by Colton Kirsten on 1/2/25.
//

import SwiftUI

struct Ball: Identifiable {
    let id = UUID()
    var position: CGPoint
    var velocity: CGSize
    let radius: CGFloat
    let color: Color
}

struct ContentView: View {
    @State private var balls: [Ball] = []
    @State private var screenSize: CGSize = .zero
    @State private var timer: Timer? = nil
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                // Make sure there's a shape covering the whole area
                Color.clear
                    .contentShape(Rectangle())
                    // We use a drag gesture with minimumDistance = 0
                    // to register a tap and get the (x, y) location
                    .gesture(
                        DragGesture(minimumDistance: 0, coordinateSpace: .local)
                            .onEnded { value in
                                addNewBall(at: value.location)
                            }
                    )
                
                // Draw the balls
                ForEach(balls) { ball in
                    Circle()
                        .fill(ball.color)
                        .frame(width: ball.radius * 2, height: ball.radius * 2)
                        .position(x: ball.position.x, y: ball.position.y)
                }
            }
            .onAppear {
                screenSize = geo.size
                startTimer()
            }
            .onDisappear {
                stopTimer()
            }
        }
    }
    
    private func startTimer() {
        stopTimer()
        // ~60 FPS
        timer = Timer.scheduledTimer(withTimeInterval: 1.0 / 60.0, repeats: true) { _ in
            updateBalls()
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func addNewBall(at location: CGPoint) {
        let randomVelocity = CGSize(
            width: CGFloat.random(in: -5...5),
            height: CGFloat.random(in: -5...5)
        )
        
        let newBall = Ball(
            position: location,
            velocity: randomVelocity,
            radius: 20,
            color: Color(
                red: .random(in: 0...1),
                green: .random(in: 0...1),
                blue: .random(in: 0...1)
            )
        )
        balls.append(newBall)
    }
    
    private func updateBalls() {
        var updatedBalls: [Ball] = []
        
        for var ball in balls {
            ball.position.x += ball.velocity.width
            ball.position.y += ball.velocity.height
            
            // Bounce on left/right
            if ball.position.x - ball.radius <= 0 {
                ball.position.x = ball.radius
                ball.velocity.width *= -1
            } else if ball.position.x + ball.radius >= screenSize.width {
                ball.position.x = screenSize.width - ball.radius
                ball.velocity.width *= -1
            }
            
            // Bounce on top/bottom
            if ball.position.y - ball.radius <= 0 {
                ball.position.y = ball.radius
                ball.velocity.height *= -1
            } else if ball.position.y + ball.radius >= screenSize.height {
                ball.position.y = screenSize.height - ball.radius
                ball.velocity.height *= -1
            }
            
            updatedBalls.append(ball)
        }
        
        balls = updatedBalls
    }
}

#Preview {
    ContentView()
}
