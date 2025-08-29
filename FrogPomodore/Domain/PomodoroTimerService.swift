//
//  PomodoroTimerService.swift
//  FrogPomodore
//
//  Created by Rodrigo Cerqueira Reis on 25/08/25.
//

import Foundation

protocol PomodoroTimerService {
    
    var pomodoro: Pomodoro { get }
    
    var onTimerUpdate: ((Pomodoro) -> Void)? { get set }
    var onPhaseChange: ((Pomodoro) -> Void)? { get set }
    
    func start()
    func pause()
    func reset()
}
