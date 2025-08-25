//
//  Pomodoro.swift
//  FrogPomodore
//
//  Created by Rodrigo Cerqueira Reis on 25/08/25.
//

import Foundation

enum PomodoroPhase {
    case work
    case shortBreak
    case longBreak
}

struct Pomodoro {
    let phase: PomodoroPhase
    let remainingTimeInSeconds: TimeInterval
    let completedWorkCycles: Int
}
