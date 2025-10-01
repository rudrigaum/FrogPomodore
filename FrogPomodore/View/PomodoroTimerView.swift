//
//  ContentView.swift
//  FrogPomodore
//
//  Created by Rodrigo Cerqueira Reis on 01/10/25.
//

import SwiftUI

struct PomodoroTimerView: View {
    
    // MARK: - State Properties
    @State private var timeRemaining: String = "25:00"
    @State private var isTimerRunning: Bool = false
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 40) {
            Text("🐸")
                .font(.system(size: 100))
            
            Text(timeRemaining)
                .font(.system(size: 72, weight: .bold, design: .monospaced))
            
            Button(action: {
                isTimerRunning.toggle()
            }) {
                Text(isTimerRunning ? "Pause" : "Start")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .frame(width: 200, height: 50)
                    .background(isTimerRunning ? Color.orange : Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(15)
            }
        }
        .padding()
    }
}

// MARK: - Preview
struct PomodoroTimerView_Previews: PreviewProvider {
    static var previews: some View {
        PomodoroTimerView()
    }
}
