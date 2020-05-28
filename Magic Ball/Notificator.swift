//
//  Notificator.swift
//  Magic Ball
//
//  Created by Anatoliy Anatolyev on 22.03.2020.
//  Copyright © 2020 Anatoliy Anatolyev. All rights reserved.
//
//import Foundation
import UIKit
import UserNotifications

class Notificator: NSObject {
    static let shared = Notificator()
    
    override init () {
        super.init()
        notificationCentre.delegate = self
    }

    
    let notificationCentre = UNUserNotificationCenter.current()
    func requestAutorization () {
        notificationCentre.requestAuthorization(options: [.alert, .badge, .sound]) { (success, error) in
            if success {
                
               //
                
            }else {
                if let error = error {
                    print(error.localizedDescription)
                }
                
            }
        }
    }
    
    func createNotification (prognose: String) {
        let content = UNMutableNotificationContent()
        
        content.title = ""
        content.subtitle = ""
        content.sound = UNNotificationSound.default
        content.body = prognose
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.5, repeats: false)
        
        let request = UNNotificationRequest(identifier: "HJKLF", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
//    func comlitionHandler() {
//        print ("###")
//    }
    
    
}

extension Notificator: UNUserNotificationCenterDelegate {
  
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler ([.alert,.badge,.sound])
    }
   
}
