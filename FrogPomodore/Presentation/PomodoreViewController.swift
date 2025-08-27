//
//  PomodoreViewController.swift
//  FrogPomodore
//
//  Created by Rodrigo Cerqueira Reis on 17/10/24.
//

import UIKit

class PomodoreViewController: UIViewController {
    
    private let pomodoreView = PomodoreView()
    
    override func loadView() {
        self.view = pomodoreView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        pomodoreView.backgroundColor = .red
    }


}

