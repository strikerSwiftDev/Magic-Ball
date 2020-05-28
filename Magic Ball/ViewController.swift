//
//  ViewController.swift
//  Magic Ball
//
//  Created by Anatoliy Anatolyev on 18.03.2020.
//  Copyright © 2020 Anatoliy Anatolyev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var ifnoLabel: UILabel!
    
    private var isBusy = false
    
    private var prognosesCount = 0
    private let defaultimer = 0.1
    
    private var previousNum: Int = 0
    
    private var receiveNotifications = true
    
    private let defaultPrognose = ""
    private let prognosesArr = ["ДА",
                        "Возможно",
                        "Неопределенно",
                        "Спроси позже",
                        "Маловероятно",
                        "НЕТ"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.stopAnimating()
        label.text = defaultPrognose
        
        
        let tapgestureRec = UITapGestureRecognizer(target: self, action: #selector(tap))
        
        self.view.addGestureRecognizer(tapgestureRec)
        
        Notificator.shared.requestAutorization()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        label.text = defaultPrognose

    }
    
    private func setRNDprognose() {
        let prognose = prognosesArr[getNewRandomNum()]
        label.text = prognose
        
//        if receiveNotifications {
//            Notificator.shared.createNotification(prognose: prognose)
//        }
        
        
    }
    
    private func getNewRandomNum() -> Int {
        var num: Int = 0
        repeat {
            num = Int.random(in: 0 ..< prognosesArr.count)
            
        } while num == previousNum
        
        previousNum = num
        return num
    }
    
    private func StartPrognose () {
        if !isBusy {
            
            isBusy = true
            ifnoLabel.isEnabled = false
            activityIndicator.startAnimating()
            
            let time = Int.random(in: 20...30)
            
            _ = Timer.scheduledTimer(withTimeInterval: defaultimer, repeats: true) { (timer) in
                
                    self.setRNDprognose()

                if self.prognosesCount < time {
                    self.prognosesCount += 1
                } else {
                    timer.invalidate()
                    self.EndPrognose()
                }
            }
        }
        
        
    }
    
    private func EndPrognose () {
        prognosesCount = 0
        activityIndicator.stopAnimating()
        isBusy = false
        ifnoLabel.isEnabled = true
    }
    
//
    @objc func tap () {
        StartPrognose()
    }
    
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            StartPrognose()
        }
        
        
    }
    
}

