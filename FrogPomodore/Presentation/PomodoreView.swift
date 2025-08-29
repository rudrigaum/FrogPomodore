//
//  PomodoreView.swift
//  FrogPomodore
//
//  Created by Rodrigo Cerqueira Reis on 17/10/24.
//

import Foundation
import UIKit

protocol PomodoroViewProtocol: UIView {
    var delegate: PomodoroViewDelegate? { get set }
    func update(with viewState: PomodoroViewState)
}

protocol PomodoroViewDelegate: AnyObject {
    func didTapStartButton()
    func didTapPauseButton()
    func didTapResetButton()
}

class PomodoreView: UIView, PomodoroViewProtocol {

    weak var delegate: PomodoroViewDelegate?

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
    
    lazy var startButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(didTapStartButton), for: .touchUpInside)
        return button
    }()

    lazy var pauseButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemYellow
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(didTapPauseButton), for: .touchUpInside)
        return button
    }()
    
    lazy var resetButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(didTapResetButton), for: .touchUpInside)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func didTapStartButton() {
        delegate?.didTapStartButton()
    }

    @objc private func didTapPauseButton() {
        delegate?.didTapPauseButton()
    }
    
    @objc private func didTapResetButton() {
        delegate?.didTapResetButton()
    }

    func update(with viewState: PomodoroViewState) {
        timeLabel.text = viewState.timerText
        phaseLabel.text = viewState.phaseTitle
        
        startButton.isHidden = viewState.startButton.isHidden
        startButton.setTitle(viewState.startButton.title, for: .normal)
        
        pauseButton.isHidden = viewState.pauseButton.isHidden
        pauseButton.setTitle(viewState.pauseButton.title, for: .normal)
        
        resetButton.isHidden = viewState.resetButton.isHidden
        resetButton.setTitle(viewState.resetButton.title, for: .normal)
    }

    private func setupView() {
        backgroundColor = .black
        addSubview(timeLabel)
        addSubview(phaseLabel)
        addSubview(startButton)
        addSubview(pauseButton)
        addSubview(resetButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            timeLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            timeLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -50),

            phaseLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            phaseLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 12),

            startButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            startButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -50),
            startButton.widthAnchor.constraint(equalToConstant: 150),
            startButton.heightAnchor.constraint(equalToConstant: 50),

            pauseButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            pauseButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -50),
            pauseButton.widthAnchor.constraint(equalToConstant: 150),
            pauseButton.heightAnchor.constraint(equalToConstant: 50),
            
            resetButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            resetButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -120),
            resetButton.widthAnchor.constraint(equalToConstant: 150),
            resetButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
