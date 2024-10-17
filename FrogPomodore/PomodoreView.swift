//
//  PomodoreView.swift
//  FrogPomodore
//
//  Created by Rodrigo Cerqueira Reis on 17/10/24.
//

import Foundation
import UIKit

class PomodoreView: UIView  {
    
    lazy var timeLabel: UILabel {
        let label = UILabel()
        label.text = "0.00"
        return label
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(timeLabel)
    }
    
    
    private
    
    
   
}
