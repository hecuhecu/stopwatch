//
//  ViewController.swift
//  Stopwatch
//
//  Created by 河村宇記 on 2021/11/19.
//

import UIKit

class ViewController: UIViewController {
    enum State {
        case idle
        case running
        case pause
    }
    
    var state: State = .idle
    
    @IBOutlet weak var timerLabel: UILabel!
    var elapsedTime: Float = 0.0
    var timer: Timer?
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //stopButton.titleLabel?.adjustsFontSizeToFitWidth = true
        stopButton.isEnabled = false
    }
    
    @IBAction func tapStart(_ sender: Any) {
        state = .running
        startButton.isEnabled = false
        stopButton.isEnabled = true
        updateUI()
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { (timer) in
            self.elapsedTime += 0.01
            let milliSecond = Int(self.elapsedTime * 100) % 100
            
            let second = Int(self.elapsedTime) % 60
            
            let minutes = Int(self.elapsedTime / 60)
            self.timerLabel.text = String(format: "%02d:%02d:%02d", minutes, second, milliSecond)
        }
    }
    
    
    @IBAction func tapStop(_ sender: Any) {
        switch state {
        case .idle:
            break
        case .running:
            if let t = timer {
                t.invalidate()
            }
            startButton.isEnabled = true
            state = .pause
        case .pause:
            elapsedTime = 0.0
            self.timerLabel.text = "00:00:00"
            stopButton.isEnabled = false
            state = .idle
        }
        
        updateUI()
    }
    
    func updateUI() {
        stopButton.setTitle(
            {
                switch state {
                case .idle:
                    return "STOP"
                case .running:
                    return "STOP"
                case .pause:
                    return "RESET"
                }
            }(),
            for: .normal
        )
        
    }
}

