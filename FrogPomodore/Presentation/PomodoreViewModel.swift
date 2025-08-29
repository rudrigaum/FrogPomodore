//
//  PomodoreViewModel.swift
//  FrogPomodore
//
//  Created by Rodrigo Cerqueira Reis on 27/08/25.
//

import Foundation

struct PomodoroButtonState {
    let title: String
    let isHidden: Bool
}

struct PomodoroViewState {
    let timerText: String
    let phaseTitle: String
    let isTimerRunning: Bool
    let startButton: PomodoroButtonState
    let pauseButton: PomodoroButtonState
    let resetButton: PomodoroButtonState
}

protocol PomodoroViewModelProtocol {
    var onStateChange: ((PomodoroViewState) -> Void)? { get set }
    
    func viewDidLoad()
    func startButtonTapped()
    func pauseButtonTapped()
    func resetButtonTapped()
}

class PomodoroViewModel: PomodoroViewModelProtocol {
    
    private var timerService: PomodoroTimerService
    
    var onStateChange: ((PomodoroViewState) -> Void)?
    
    init(timerService: PomodoroTimerService) {
        self.timerService = timerService
    }
    
    
    func viewDidLoad() {

        timerService.onTimerUpdate = { [weak self] pomodoro in
            self?.updateState(with: pomodoro)
        }
        
        updateState(with: Pomodoro(phase: .work, remainingTimeInSeconds: 25 * 60, completedWorkCycles: 0, isTimerRunning: false))
    }
    
    func startButtonTapped() {
        timerService.start()
        updateState(with: timerService.pomodoro)
    }
    
    func pauseButtonTapped() {
        timerService.pause()
        updateState(with: timerService.pomodoro)
    }
    
    func resetButtonTapped() {
        timerService.reset()
        updateState(with: timerService.pomodoro)
    }
    
    private func updateState(with pomodoro: Pomodoro) {
        let viewState = PomodoroViewState(
            timerText: formatTime(pomodoro.remainingTimeInSeconds),
            phaseTitle: pomodoro.phase.title, isTimerRunning: false,
            startButton: PomodoroButtonState(title: "Start", isHidden: pomodoro.isTimerRunning),
            pauseButton: PomodoroButtonState(title: "Pause", isHidden: !pomodoro.isTimerRunning),
            resetButton: PomodoroButtonState(title: "Restart", isHidden: false)
        )
        onStateChange?(viewState)
    }
    
    private func formatTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

extension PomodoroPhase {
    var title: String {
        switch self {
        case .work:
            return "Work"
        case .shortBreak:
            return "Short Break"
        case .longBreak:
            return "Long Break"
        }
    }
}
