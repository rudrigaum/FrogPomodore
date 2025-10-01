//
//  PomodoroTimerViewModel.swift
//  FrogPomodore
//
//  Created by Rodrigo Cerqueira Reis on 01/10/25.
//

import Foundation
import Combine

@MainActor
final class PomodoroTimerViewModel: ObservableObject {
    
    // MARK: - Published Properties
    @Published var timeRemaining: String = "25:00"
    @Published var isTimerRunning: Bool = false
    
    var buttonText: String {
        isTimerRunning ? "Pause" : "Start"
    }
    
    // MARK: - Public Methods
    func handleToggleButtonTap() {
        isTimerRunning.toggle()
        
        if isTimerRunning {
            print("Timer has started.")
        } else {
            print("Timer has paused.")
        }
    }
}
