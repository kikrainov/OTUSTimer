//
//  ViewController.swift
//  OTUSTimer
//
//  Created by Kirill Kraynov on 04.11.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    var timer: Timer?
    var intValue: Int = 0
    
    var timerIsWorking: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print("Таймер в viewDidLoad - \(timerIsWorking)")
        
        /*if timerIsWorking == false {
            pauseTimer()
        }*/
  
        NotificationCenter.default.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.willResignActiveNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(appMovedToForeground), name: UIApplication.didBecomeActiveNotification, object: nil)
        
        //timerIsWorking = false
    }
    
    

    @objc func appMovedToBackground() {
        pauseTimer()
        timerIsWorking = false
        print("On back")
    }
    
    @objc func appMovedToForeground() {
        launchTimer()
        timerIsWorking = true
        print("On fore")
    }


    @IBAction func startButtonClick(_ sender: Any) {
        timerIsWorking = true
        print("Таймер после старта - \(timerIsWorking)")
        startButton.isEnabled = false
        stopButton.isEnabled = true
        launchTimer()
    }
    
    
    @IBAction func stopButtonClick(_ sender: Any) {
        timerIsWorking = false
        print("Таймер после остановки - \(timerIsWorking)")
        startButton.isEnabled = true
        stopButton.isEnabled = false
        pauseTimer()
    }
    
    @objc private func launchTimer() {
        timer?.invalidate()
        let timer = Timer(timeInterval: 1, target: self, selector: #selector(timerLogics), userInfo: nil, repeats: true)
        self.timer = timer
        RunLoop.main.add(timer, forMode: .common)
    }
    
    @objc private func pauseTimer() {
        timer?.invalidate()
    }
    
    
    
    @objc func timerLogics() {
        intValue += 1
        let sec = intValue % 60
        let secToString = String(format: "%02d", sec)
        let min = intValue / 60
        let minToString = String(format: "%02d", min)
                
        timerLabel.text = "\(minToString):\(secToString)"
    }
    
}

