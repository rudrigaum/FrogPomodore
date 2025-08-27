//
//  PomodoreViewController.swift
//  FrogPomodore
//
//  Created by Rodrigo Cerqueira Reis on 17/10/24.
//

import UIKit

class PomodoreViewController: UIViewController, PomodoroViewDelegate {
    
    // MARK: - Properties
    private let pomodoreView = PomodoreView()
    private var viewModel: PomodoroViewModelProtocol
    
    // MARK: - Dependency Injection
    init(viewModel: PomodoroViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func loadView() {
        self.view = pomodoreView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pomodoreView.delegate = self
        
        viewModel.onStateChange = { [weak self] viewState in
            self?.pomodoreView.update(with: viewState)
        }
        
        viewModel.viewDidLoad()
    }
    
    // MARK: - PomodoroViewDelegate
    func didTapActionButton() {
        if pomodoreView.actionButton.title(for: .normal) == "Pause" {
            viewModel.pauseButtonTapped()
        } else {
            viewModel.startButtonTapped()
        }
    }
}
