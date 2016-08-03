//
//  ActionableViewController.swift
//  UserNotificationDemo
//
//  Created by WANG WEI on 2016/08/03.
//  Copyright © 2016年 OneV's Den. All rights reserved.
//

import UIKit
import UserNotifications

class ActionableViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func notificationButtonPressed(_ sender: AnyObject) {
        
        let content = UNMutableNotificationContent()
        content.body = "Please say something."
        
        // The saySomething category is registered in AppDelegate
        content.categoryIdentifier = UserNotificationCategoryType.saySomething.rawValue
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        let request = UNNotificationRequest(identifier: UserNotificationType.actionable.rawValue, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
}
