//
//  PomodoroViewModel.swift
//  FrogPomodore
//
//  Created by Rodrigo Cerqueira Reis on 27/08/25.
//

import Foundation

// MARK: - View State
struct PomodoroViewState {
    let timerText: String
    let buttonTitle: String
    let phaseTitle: String
    let isTimerRunning: Bool
}

// MARK: - Protocol
protocol PomodoroViewModelProtocol {
    var onStateChange: ((PomodoroViewState) -> Void)? { get set }
    
    func viewDidLoad()
    func startButtonTapped()
    func pauseButtonTapped()
    func resetButtonTapped()
}

// MARK: - Implementation
class PomodoroViewModel: PomodoroViewModelProtocol {
    
    private var timerService: PomodoroTimerService
    
    var onStateChange: ((PomodoroViewState) -> Void)?
    
    init(timerService: PomodoroTimerService) {
        self.timerService = timerService
    }
    
    // MARK: - Métodos para a View
    
    func viewDidLoad() {
        timerService.onTimerUpdate = { [weak self] pomodoro in
            self?.updateState(with: pomodoro)
        }
        
        updateState(with: Pomodoro(phase: .work, remainingTimeInSeconds: 25 * 60, completedWorkCycles: 0))
    }
    
    func startButtonTapped() {
        timerService.start()
    }
    
    func pauseButtonTapped() {
        timerService.pause()
    }
    
    func resetButtonTapped() {
        timerService.reset()
    }
    
    // MARK: - Private Logic
    
    private func updateState(with pomodoro: Pomodoro) {
        let viewState = PomodoroViewState(
            timerText: formatTime(pomodoro.remainingTimeInSeconds),
            buttonTitle: "Pause",
            phaseTitle: pomodoro.phase == .work ? "Work" : "Pause",
            isTimerRunning: true
        )
        onStateChange?(viewState)
    }
    
    private func formatTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
