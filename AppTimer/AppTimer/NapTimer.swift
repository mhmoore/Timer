//
//  NapTimer.swift
//  AppTimer
//
//  Created by Michael Moore on 8/6/19.
//  Copyright © 2019 Michael Moore. All rights reserved.
//

import Foundation

protocol NapTimerDelegate: class {
    func timerSecondTicked()
    func timerStopped()
    func timerCompleted()
}


// helper class
class NapTimer {
    
    // MARK: - Properties
    
    private var timer: Timer?
    
    var timeLeft: TimeInterval?
    weak var delegate: NapTimerDelegate?
    var isOn: Bool {
        return timeLeft == nil ? false : true
    }
    
    // MARK: - Public Methods
    
    func timeLeftAsString() -> String {
        let timeRemaining = Int(timeLeft ?? 3 * 60)
        let minutesRemaining = timeRemaining / 60
        let secondsRemaining = timeRemaining - (minutesRemaining * 60)
        return String(format: "%02d : %02d", arguments: [minutesRemaining, secondsRemaining])
    }
    
    func startTimer(_ time: TimeInterval) {
        if isOn {
            print("Timer is already running")
        } else {
            self.timeLeft = time
            self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (_) in
                print("second ticking")
                self.secondTicked()
            })
        }
    }
    
    func stopTimer() {
        timeLeft = nil
        timer?.invalidate()
        print("Stopped Timer")
        delegate?.timerStopped()
    }
    
    // MARK: - Private Methods
    
    private func secondTicked() {
        guard let timeLeft = timeLeft else { return }
        if timeLeft > 0 {
            // lower the time by one second
            self.timeLeft = timeLeft - 1
            print(self.timeLeftAsString())
            // let the view controller know
            delegate?.timerSecondTicked()
            
        } else {
            // timer complete
            stopTimer()
            // let the view controller know
            delegate?.timerCompleted()
        }
    }
    
   
    
}
