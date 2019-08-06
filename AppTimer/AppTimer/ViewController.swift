//
//  ViewController.swift
//  AppTimer
//
//  Created by Michael Moore on 8/6/19.
//  Copyright © 2019 Michael Moore. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var timerButton: UIButton!
    
    // MARK: - Properties
    
    var napTimer = NapTimer()
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        napTimer.delegate = self
    }

    // MARK: - Actions
    
    @IBAction func timerButtonTapped(_ sender: UIButton) {
        if napTimer.isOn {
            napTimer.stopTimer()
        } else {
           napTimer.startTimer(5)
        }
        
        
    }
    
    // MARK: - Custom Methods
    func updateLabelAndButton() {
        timerLabel.text = napTimer.timeLeftAsString()
        var buttonTitle = ""
        var buttonColor: UIColor = .white
    
        if napTimer.isOn {
        buttonTitle = "STOP"
        buttonColor = .red
        } else {
        buttonTitle = "Nap Time!"
        buttonColor = .white
        }
    
        timerButton.setTitle(buttonTitle, for: .normal)
        timerButton.setTitleColor(buttonColor, for: .normal)
    }
    
}

// MARK: - NapTimer Delegate
extension ViewController: NapTimerDelegate {
    func timerSecondTicked() {
        updateLabelAndButton()
    }
    
    func timerStopped() {
        updateLabelAndButton()
    }
    
    func timerCompleted() {
        updateLabelAndButton()
    }
    
    
}
