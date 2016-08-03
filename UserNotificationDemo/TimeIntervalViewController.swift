//
//  TimeIntervalViewController.swift
//  UserNotificationDemo
//
//  Created by WANG WEI on 2016/08/03.
//  Copyright © 2016年 OneV's Den. All rights reserved.
//

import UIKit
import UserNotifications

class TimeIntervalViewController: UIViewController {
    
    var notificationType: UserNotificationType!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var timeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = notificationType.title
        descriptionLabel.text = notificationType.descriptionText
    }
    
    @IBAction func scheduleButtonPressed(_ sender: AnyObject) {
        guard let text = timeTextField.text, let timeInterval = TimeInterval(text) else {
            print("Not valid time interval")
            return
        }
        
        // Create notification content
        let content = UNMutableNotificationContent()
        content.title = "Time Interval Notification"
        content.body = "My first notification"
        
        // Create a trigger to decide when/where to present the notification
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
        
        // Create an identifier for this notification. So you could manage it later.
        let requestIdentifier = notificationType.rawValue
        
        // The request describes this notification.
        let request = UNNotificationRequest(identifier: requestIdentifier, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                UIAlertController.showConfirmAlert(message: error.localizedDescription, in: self)
            } else {
                print("Time Interval Notification scheduled: \(requestIdentifier)")
            }
        }
    }
}

