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
    var elapsedTime: Float = 0.0
    var timer: Timer?
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        stopButton.isEnabled = false
        resetButton.isEnabled = false
        
        //角丸の設定
        startButton.layer.cornerRadius = 10
        stopButton.layer.cornerRadius = 10
        resetButton.layer.cornerRadius = 10
        
        //影の濃さ
        startButton.layer.shadowOpacity = 0.7
        stopButton.layer.shadowOpacity = 0.7
        resetButton.layer.shadowOpacity = 0.7
        
        //影の方向
        startButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        stopButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        resetButton.layer.shadowOffset = CGSize(width: 5, height: 5)
    }
    
    @IBAction func tapStart(_ sender: Any) {
        state = .running
        switchButton()
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { (timer) in
            self.elapsedTime += 0.01
            let milliSecond = Int(self.elapsedTime * 100) % 100
            
            let second = Int(self.elapsedTime) % 60
            
            let minutes = Int(self.elapsedTime / 60)
            self.timerLabel.text = String(format: "%02d:%02d:%02d", minutes, second, milliSecond)
        }
    }
    
    @IBAction func tapStop(_ sender: Any) {
        if let t = timer {
            t.invalidate()
        }
        state = .pause
        switchButton()
    }
    
    @IBAction func tapReset(_ sender: Any) {
        elapsedTime = 0.0
        self.timerLabel.text = "00:00:00"
        state = .idle
        switchButton()
    }
    
    func switchButton() {
        switch state {
        case .idle:
            stopButton.isEnabled = false
            resetButton.isEnabled = false
        case .running:
            startButton.isEnabled = false
            stopButton.isEnabled = true
            resetButton.isEnabled = false
        case .pause:
            startButton.isEnabled = true
            stopButton.isEnabled = false
            resetButton.isEnabled = true
        }
    }
}

