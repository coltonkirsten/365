//
//  ContentView.swift
//  HappyNewYear! (day 1)
//
//  Created by Colton Kirsten on 1/1/25.
//

import SwiftUI
import Foundation

func getCurrentYear() -> String {
    let currentYear = Calendar.current.component(.year, from: Date())
    return "\(currentYear)"
}

struct ContentView: View {
    @State private var showFireworks = false
    @State private var showCelebrateButton = true
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
                
                Text("Happy \(getCurrentYear())!🎉")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .shadow(radius: 10)
                    .padding(20)
                    .background(.blue)
                    .cornerRadius(10)
                
                Spacer()
                
                if showCelebrateButton{
                    Button(action: {
                        withAnimation {
                            showFireworks.toggle()
                            showCelebrateButton.toggle()
                        }
                    }) {
                        Text("Celebrate!")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.purple)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                    }
                    .padding()
                }
                
                Spacer()
            }
            
            if showFireworks {
                FireworksView()
            }

        }
    }
}

struct FireworksView: View {
    @State private var positions: [(x: CGFloat, y: CGFloat)] = []
    @State private var sparkles = false

    let numberOfFireworks = 10

    var body: some View {
        ZStack {
            ForEach(0..<numberOfFireworks, id: \.self) { index in
                Circle()
                    .fill(Color.random)
                    .frame(width: 10, height: 10)
                    .offset(x: positions.indices.contains(index) ? positions[index].x : 0,
                            y: positions.indices.contains(index) ? positions[index].y : 0)
                    .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true), value: sparkles)
            }
        }
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                generateRandomPositions()
            }
            sparkles.toggle()
        }
    }

    private func generateRandomPositions() {
        positions = (0..<numberOfFireworks).map { _ in
            (
                x: CGFloat.random(in: -200...200),
                y: CGFloat.random(in: -400...400)
            )
        }
    }
}


extension Color {
    static var random: Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}

extension CGFloat {
    static func random(in range: ClosedRange<Double>) -> CGFloat {
        return CGFloat(Double.random(in: range))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
