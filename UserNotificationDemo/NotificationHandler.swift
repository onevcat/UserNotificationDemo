//
//  NotificationHandler.swift
//  UserNotificationDemo
//
//  Created by WANG WEI on 2016/08/03.
//  Copyright © 2016年 OneV's Den. All rights reserved.
//

import Foundation
import UserNotifications

enum UserNotificationType: String {
    case timeInterval
    case timeIntervalForeground
    case pendingRemoval
    case pendingUpdate
    case deliveredRemoval
    case deliveredUpdate
}

class NotificationHandler: NSObject, UNUserNotificationCenterDelegate {
    
    // The method will be called on the delegate only if the application is in the foreground. If the method is not implemented or the handler is not called in a timely manner then the notification will not be presented. The application can choose to have the notification presented as a sound, badge, alert and/or in the notification list. This decision should be based on whether the information in the notification is otherwise visible to the user.
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: (UNNotificationPresentationOptions) -> Void) {
        
        guard let notificationType = UserNotificationType(rawValue: notification.request.identifier) else {
            completionHandler([])
            return
        }

        let options: UNNotificationPresentationOptions
        
        switch notificationType {
        case .timeIntervalForeground:
            options = [.alert, .sound]
        case .pendingRemoval:
            options = [.alert, .sound]
        case .pendingUpdate:
            options = [.alert, .sound]
        case .deliveredRemoval:
            options = [.alert, .sound]
        case .deliveredUpdate:
            options = [.alert, .sound]
        default:
            options = []
        }
        completionHandler(options)
    }
    
    // The method will be called on the delegate when the user responded to the notification by opening the application, dismissing the notification or choosing a UNNotificationAction. The delegate must be set before the application returns from applicationDidFinishLaunching:.
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: () -> Void) {
        
    }
}

extension UserNotificationType {
    var descriptionText: String {
        switch self {
        case .timeInterval: return "You need to switch to background to see the notification."
        case .timeIntervalForeground: return "The notification will show in-app. See NotificationHandler for more."
        default: return rawValue
        }
    }
    
    var title: String {
        switch self {
        case .timeInterval: return "Time"
        case .timeIntervalForeground: return "Foreground"
        default: return rawValue
        }
    }

}

