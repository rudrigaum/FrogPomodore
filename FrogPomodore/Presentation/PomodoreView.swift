//
//  PomodoreView.swift
//  FrogPomodore
//
//  Created by Rodrigo Cerqueira Reis on 17/10/24.
//

import Foundation
import UIKit

// MARK: - Protocol for View
protocol PomodoroViewProtocol: UIView {
    var delegate: PomodoroViewDelegate? { get set }
    func update(with viewState: PomodoroViewState)
}

// MARK: - Delegate
protocol PomodoroViewDelegate: AnyObject {
    func didTapActionButton()
}

class PomodoreView: UIView, PomodoroViewProtocol {
    
    // MARK: - Properties
    weak var delegate: PomodoroViewDelegate?
    
    // MARK: - UI Components
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 56, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var phaseLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var actionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(didTapActionButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    @objc private func didTapActionButton() {
        delegate?.didTapActionButton()
    }
    
    // MARK: - UI Update Methods
    func update(with viewState: PomodoroViewState) {
        timeLabel.text = viewState.timerText
        phaseLabel.text = viewState.phaseTitle
        actionButton.setTitle(viewState.buttonTitle, for: .normal)
    }
    
    // MARK: - UI Setup
    private func setupView() {
        backgroundColor = .black
        addSubview(timeLabel)
        addSubview(phaseLabel)
        addSubview(actionButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            timeLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            timeLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -50),
            
            phaseLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            phaseLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 12),
            
            actionButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            actionButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -50),
            actionButton.widthAnchor.constraint(equalToConstant: 150),
            actionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
