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
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func startButtonTapped(_ sender: Any) {
        if !isStarted {
            startTimer()
            isStarted = true
            updateTimer()
        } else {
            timer.invalidate()
            isStarted = false
        }
    }
    

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
        } else if time == 0 && isWorkTime == false {
            isWorkTime = true
            time = Metric.workTime
            timerLabel.textColor = .red
            startButton.setImage(#imageLiteral(resourceName: "playWorkTime"), for: .normal)
        }
        timerLabel.text = formatTime()
    }
    
    func formatTime() -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return "\(minutes):\(seconds)"
        
    }

}

extension ViewController {
    enum Metric {
        static let restTime = 300
        static let workTime = 1500
    }
}

