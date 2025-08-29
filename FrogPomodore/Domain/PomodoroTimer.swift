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
    
    private var internalRemainingTime: TimeInterval
    private var timer: Timer?
    private var currentPhase: PomodoroPhase = .work
    private var timeRemainingInSeconds: TimeInterval = 25 * 60
    private var completedWorkCycles: Int = 0
    private let workDuration: TimeInterval = 25 * 60
    private let shortBreakDuration: TimeInterval = 5 * 60
    private let longBreakDuration: TimeInterval = 15 * 60
    
    init() {
        self.internalRemainingTime = 25 * 60
        self.pomodoro = Pomodoro(
            phase: .work,
            remainingTimeInSeconds: self.internalRemainingTime,
            completedWorkCycles: 0,
            isTimerRunning: false
        )
    }
    
    func start() {
        guard timer == nil else { return }
        
        self.pomodoro = Pomodoro(
            phase: self.pomodoro.phase,
            remainingTimeInSeconds: self.internalRemainingTime,
            completedWorkCycles: self.pomodoro.completedWorkCycles,
            isTimerRunning: isRunning
        )
        
        onTimerUpdate?(self.pomodoro)
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
             guard let self = self else { return }

             self.internalRemainingTime -= 1

             self.pomodoro = Pomodoro(
                 phase: self.pomodoro.phase,
                 remainingTimeInSeconds: self.internalRemainingTime,
                 completedWorkCycles: self.pomodoro.completedWorkCycles,
                 isTimerRunning: true
             )

             self.onTimerUpdate?(self.pomodoro)
         }
    }
    
    func pause() {
        timer?.invalidate()
        timer = nil
        
        self.pomodoro = Pomodoro(
            phase: self.pomodoro.phase,
            remainingTimeInSeconds:  self.internalRemainingTime,
            completedWorkCycles: self.pomodoro.completedWorkCycles,
            isTimerRunning: isRunning
        )
        
        timer?.invalidate()
        timer = nil
    }
    
    func reset() {
        timer?.invalidate()
        timer = nil
        
        self.internalRemainingTime = 25 * 60
        
        self.pomodoro = Pomodoro(
            phase: .work,
            remainingTimeInSeconds: self.internalRemainingTime,
            completedWorkCycles: 0,
            isTimerRunning: false
        )
        onTimerUpdate?(self.pomodoro)
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
