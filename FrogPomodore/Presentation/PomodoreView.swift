//
//  PomodoreView.swift
//  FrogPomodore
//
//  Created by Rodrigo Cerqueira Reis on 17/10/24.
//

import Foundation
import UIKit

class PomodoreView: UIView  {
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "0.00"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(timeLabel)
    }
    
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: bottomAnchor, constant: 12),
            timeLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
            
        ])
    }
    
    
   
}
