//
//  ContentView.swift
//  FrogPomodore
//
//  Created by Rodrigo Cerqueira Reis on 01/10/25.
//

import SwiftUI
struct PomodoroTimerView: View {
    
    // MARK: - Properties
    @StateObject private var viewModel = PomodoroTimerViewModel()
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 40) {
            Text("🐸")
                .font(.system(size: 100))
           
            Text(viewModel.timeRemaining)
                .font(.system(size: 72, weight: .bold, design: .monospaced))
            
            Button(action: {

                viewModel.handleToggleButtonTap()
            }) {
                Text(viewModel.buttonText)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .frame(width: 200, height: 50)
                    .background(viewModel.isTimerRunning ? Color.orange : Color.green)
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
