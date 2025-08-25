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
    private var timeRemaining: TimeInterval = 25 * 60 // 25 minutos
    
    func start() {
    
    }
    
    func pause() {
    
    }
    
    func reset() {
    
    }
}
