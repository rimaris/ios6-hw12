//
//  ViewController.swift
//  pomidor
//
//  Created by Мария Солодова on 27.05.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var startButton: UIButton!
    
    @IBOutlet weak var timerLabel: UILabel!
    
    var timer = Timer()
    var isStarted = false
    var time = Metric.workTime
    var isWorkTime = true
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        timerLabel.text = formatTime()
    }
    
    // MARK: - Methods for button
    
    @IBAction func startButtonTapped(_ sender: Any) {
        if !isStarted {
            startTimer()
            isStarted = true
            updateTimer()
            if isWorkTime {
                startButton.setImage(#imageLiteral(resourceName: "pauseWorkTime"), for: .normal)
            } else {
                startButton.setImage(#imageLiteral(resourceName: "pauseRestTime"), for: .normal)
            }
        } else {
            timer.invalidate()
            isStarted = false
            if isWorkTime {
                startButton.setImage(#imageLiteral(resourceName: "playWorkTime"), for: .normal)
            } else {
                startButton.setImage(#imageLiteral(resourceName: "playRestTime"), for: .normal)
            }
        }
    }
    

    // MARK: - Methods for timer
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    
    @objc func updateTimer() {
        time -= 1
        if time == 0 && isWorkTime == true {
            isWorkTime = false
            time = Metric.restTime
            timerLabel.textColor = .green
            startButton.setImage(#imageLiteral(resourceName: "playRestTime"), for: .normal)
            isStarted = false
            timer.invalidate()
        } else if time == 0 && isWorkTime == false {
            isWorkTime = true
            time = Metric.workTime
            timerLabel.textColor = .red
            startButton.setImage(#imageLiteral(resourceName: "playWorkTime"), for: .normal)
            isStarted = false
            timer.invalidate()
        }
        timerLabel.text = formatTime()
    }
    
    // MARK: Methods for label
    
    func formatTime() -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
        
    }

}

// MARK: Metrics
extension ViewController {
    enum Metric {
        static let restTime = 5
        static let workTime = 5
    }
}

