//
//  MediaViewController.swift
//  UserNotificationDemo
//
//  Created by WANG WEI on 2016/08/05.
//  Copyright © 2016年 OneV's Den. All rights reserved.
//

import UIKit
import UserNotifications

class MediaViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func notificationButtonPressed(_ sender: AnyObject) {
        // Create notification content
        let content = UNMutableNotificationContent()
        content.title = "Image Notification"
        content.body = "Show me an image!"
        
        if let imageURL = Bundle.main.url(forResource: "image", withExtension: "jpg"),
           let attachment = try? UNNotificationAttachment(identifier: "imageAttachment", url: imageURL, options: nil)
        {
            content.attachments = [attachment]
        }
        
        // Create a trigger to decide when/where to present the notification
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let requestIdentifier = UserNotificationType.media.rawValue
        
        // The request describes this notification.
        let request = UNNotificationRequest(identifier: requestIdentifier, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                UIAlertController.showConfirmAlert(message: error.localizedDescription, in: self)
            } else {
                print("Media Notification scheduled: \(requestIdentifier)")
            }
        }
    }
    

}
