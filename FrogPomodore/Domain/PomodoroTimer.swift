//
//  PomodoroTimer.swift
//  FrogPomodore
//
//  Created by Rodrigo Cerqueira Reis on 25/08/25.
//

import Foundation

class PomodoroTimer: PomodoroTimerService {
    
    var pomodoro: Pomodoro
    var onTimerUpdate: ((Pomodoro) -> Void)?
    var onPhaseChange: ((Pomodoro) -> Void)?
    var isRunning: Bool = false
    
    private var timer: Timer?
    private var currentPhase: PomodoroPhase = .work
    private var timeRemainingInSeconds: TimeInterval = 25 * 60
    private var completedWorkCycles: Int = 0
    private let workDuration: TimeInterval = 25 * 60
    private let shortBreakDuration: TimeInterval = 5 * 60
    private let longBreakDuration: TimeInterval = 15 * 60
    
    init() {
        self.pomodoro = Pomodoro(
            phase: .work,
            remainingTimeInSeconds: 25 * 60,
            completedWorkCycles: 0,
            isTimerRunning: false
        )
    }
    
    func start() {
        guard !isRunning else { return }
        isRunning = true
        
        self.pomodoro = Pomodoro(
            phase: self.pomodoro.phase,
            remainingTimeInSeconds: self.pomodoro.remainingTimeInSeconds,
            completedWorkCycles: self.pomodoro.completedWorkCycles,
            isTimerRunning: isRunning
        )
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.updateTimer()
        }
    }
    
    func pause() {
        isRunning = false
        
        self.pomodoro = Pomodoro(
            phase: self.pomodoro.phase,
            remainingTimeInSeconds: self.pomodoro.remainingTimeInSeconds,
            completedWorkCycles: self.pomodoro.completedWorkCycles,
            isTimerRunning: isRunning
        )
        
        timer?.invalidate()
        timer = nil
    }
    
    func reset() {
        isRunning = false
        
        self.pomodoro = Pomodoro(
            phase: self.pomodoro.phase,
            remainingTimeInSeconds: 25 * 60,
            completedWorkCycles: 0,
            isTimerRunning: isRunning
        )
        
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
            completedWorkCycles: completedWorkCycles,
            isTimerRunning: self.isRunning
        )
        onTimerUpdate?(pomodoro)
    }
    
    private func notifyPhaseChange() {
        let pomodoro = Pomodoro(
            phase: currentPhase,
            remainingTimeInSeconds: timeRemainingInSeconds,
            completedWorkCycles: completedWorkCycles,
            isTimerRunning: self.isRunning
        )
        onPhaseChange?(pomodoro)
    }
}
