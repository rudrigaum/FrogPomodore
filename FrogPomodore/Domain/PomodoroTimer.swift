//
//  PomodoroTimer.swift
//  FrogPomodore
//
//  Created by Rodrigo Cerqueira Reis on 25/08/25.
//

import Foundation

class PomodoroTimer: PomodoroTimerService {
    
    var onTimerUpdate: ((Pomodoro) -> Void)?
    var onPhaseChange: ((Pomodoro) -> Void)?
    
     private var timer: Timer?
     private var currentPhase: PomodoroPhase = .work
     private var timeRemainingInSeconds: TimeInterval = 25 * 60
     private var completedWorkCycles: Int = 0
     private let workDuration: TimeInterval = 25 * 60
     private let shortBreakDuration: TimeInterval = 5 * 60
     private let longBreakDuration: TimeInterval = 15 * 60
    
    init(initialTimeInSeconds: TimeInterval? = nil) {
        if let time = initialTimeInSeconds {
            self.timeRemainingInSeconds = time
        }
    }
    
    func start() {
        guard timer == nil else { return }
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.updateTimer()
        }
    }
    
    func pause() {
        timer?.invalidate()
        timer = nil
    }
    
    func reset() {
        pause()
        currentPhase = .work
        timeRemainingInSeconds = workDuration
        completedWorkCycles = 0
        notifyUpdate()
    }
    
    private func updateTimer() {
        if timeRemainingInSeconds > 0 {
            timeRemainingInSeconds -= 1
            notifyUpdate()
        } else {
            moveToNextPhase()
        }
    }
    
    private func moveToNextPhase() {
        pause()
        
        switch currentPhase {
        case .work:
            completedWorkCycles += 1
            if completedWorkCycles % 4 == 0 {
                currentPhase = .longBreak
                timeRemainingInSeconds = longBreakDuration
            } else {
                currentPhase = .shortBreak
                timeRemainingInSeconds = shortBreakDuration
            }
        case .shortBreak, .longBreak:
            currentPhase = .work
            timeRemainingInSeconds = workDuration
        }
        
        notifyPhaseChange()
    }
    
    private func notifyUpdate() {
        let pomodoro = Pomodoro(
            phase: currentPhase,
            remainingTimeInSeconds: timeRemainingInSeconds,
            completedWorkCycles: completedWorkCycles
        )
        onTimerUpdate?(pomodoro)
    }
    
    private func notifyPhaseChange() {
        let pomodoro = Pomodoro(
            phase: currentPhase,
            remainingTimeInSeconds: timeRemainingInSeconds,
            completedWorkCycles: completedWorkCycles
        )
        onPhaseChange?(pomodoro)
    }
}
