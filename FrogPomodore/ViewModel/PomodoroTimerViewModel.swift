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
    
    // MARK: - Private Properties
    private var timerTask: Task<Void, Error>?
    private var totalSeconds: Int = 25 * 60 // 25 minutes
    
    // MARK: - Public Methods
    func handleToggleButtonTap() {
        isTimerRunning.toggle()
        
        if isTimerRunning {
            startTimer()
        } else {
            pauseTimer()
        }
    }
    
    // MARK: - Private Timer Methods
    private func startTimer() {
        timerTask?.cancel()
        
        timerTask = Task {
            while totalSeconds > 0 {
                try await Task.sleep(for: .seconds(1))
                
                try Task.checkCancellation()
                
                totalSeconds -= 1
                updateTimeRemaining()
            }
            
            isTimerRunning = false
        }
    }
    
    private func pauseTimer() {
        timerTask?.cancel()
    }
    
    private func updateTimeRemaining() {
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        self.timeRemaining = String(format: "%02d:%02d", minutes, seconds)
    }
}
