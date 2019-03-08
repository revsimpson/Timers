//
//  ViewController.swift
//  Timers
//
//  Created by Richard Simpson on 08/03/2019.
//  Copyright © 2019 Richard Simpson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var countdownTimerLabel: UILabel!
    var countdownTimer : Timer?
    var countdownTIme : Int = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startTimers()
        startTimerWithRunloop()
    }

    func startTimers() {
        // Both Timer run on the main thread...so if there is a lot of UI going on they have the chance not to fire.
        let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (thetimer) in
            print("Timer callled")
        }
        countdownTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onCountdownTimer), userInfo: nil, repeats: true)
        countdownTimer?.tolerance = 0.1
        countdownTimer?.fire()
        timer.fire()
    }
    
    func startTimerWithRunloop(){
        // When you use a Runloop the Timer will always fire
        let runloopTimer = Timer(timeInterval: 2.0, repeats: true) { (_) in
            print("Runloop timer called")
        }
        RunLoop.current.add(runloopTimer, forMode: .common)
        runloopTimer.fire()
    }
    
    @objc func onCountdownTimer() {
        countdownTIme -= 1
        countdownTimerLabel.text = "\(countdownTIme) seconds left"
        
        if countdownTIme == 0 {
            countdownTimer?.invalidate()
            countdownTimer = nil
        }
    }
}

