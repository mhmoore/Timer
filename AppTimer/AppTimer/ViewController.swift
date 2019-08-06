//
//  ViewController.swift
//  AppTimer
//
//  Created by Michael Moore on 8/6/19.
//  Copyright © 2019 Michael Moore. All rights reserved.
//

import UIKit
import UserNotifications

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
    
    func presentAlert() {
        // create alert controller
        let alertController = UIAlertController(title: "Time to get up!", message: "or would you like to keep sleeping?", preferredStyle: .alert
        )
        // add textField
        alertController.addTextField { (textField) in
            textField.keyboardType = .numberPad
            textField.placeholder = "How many more minutes of sleep?"
        }
        // add actions
        let dismissAction = UIAlertAction(title: "I'm Awake!", style: .destructive, handler: nil)
        alertController.addAction(dismissAction)
            
            let snoozeAction = UIAlertAction(title: "Snooze", style: .default, handler: { (_) in
                // IF there's a textField
                if let textField = alertController.textFields?.first,
                    // and IF there's text in it
                    let inputText = textField.text,
                    // and IF that text is convertable to a double
                    let textAsDouble = Double(inputText) {
                    // THEN start the timer over
                    self.napTimer.startTimer((textAsDouble * 60))
                }
            })
            alertController.addAction(snoozeAction)
            alertController.addAction(dismissAction)
        // present alert controller
        present(alertController, animated: true)
        
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
        presentAlert()
    }
    
    
}
