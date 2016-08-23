//
//  NotificationHandler.swift
//  UserNotificationDemo
//
//  Created by WANG WEI on 2016/08/03.
//  Copyright © 2016年 OneV's Den. All rights reserved.
//

import UIKit
import UserNotifications

enum UserNotificationType: String {
    case timeInterval
    case timeIntervalForeground
    case pendingRemoval
    case pendingUpdate
    case deliveredRemoval
    case deliveredUpdate
    case actionable
    case mutableContent
    case media
    case customUI
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



enum UserNotificationCategoryType: String {
    case saySomething
    case customUI
}

enum SaySomethingCategoryAction: String {
    case input
    case goodbye
    case none
}

enum CustomizeUICategoryAction: String {
    case `switch`
    case open
    case dismiss
}

class NotificationHandler: NSObject, UNUserNotificationCenterDelegate {
    
    // The method will be called on the delegate only if the application is in the foreground. If the method is not implemented or the handler is not called in a timely manner then the notification will not be presented. The application can choose to have the notification presented as a sound, badge, alert and/or in the notification list. This decision should be based on whether the information in the notification is otherwise visible to the user.
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
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
        case .actionable:
            options = [.alert, .sound]
        case .media:
            options = [.alert, .sound]
        default:
            options = []
        }
        completionHandler(options)
    }
    
    // The method will be called on the delegate when the user responded to the notification by opening the application, dismissing the notification or choosing a UNNotificationAction. The delegate must be set before the application returns from applicationDidFinishLaunching:.
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        if let category = UserNotificationCategoryType(rawValue: response.notification.request.content.categoryIdentifier) {
            switch category {
            case .saySomething:
                handleSaySomthing(response: response)
            case .customUI:
                handleCustomUI(response: response)
            }
        }
        completionHandler()
    }
    
    private func handleSaySomthing(response: UNNotificationResponse) {
        let text: String
        
        if let actionType = SaySomethingCategoryAction(rawValue: response.actionIdentifier) {
            switch actionType {
            case .input: text = (response as! UNTextInputNotificationResponse).userText
            case .goodbye: text = "Goodbye"
            case .none: text = ""
            }
        } else {
            // Only tap or clear. (You will not receive this callback when user clear your notification unless you set .customDismissAction as the option of category)
            text = ""
        }
        
        if !text.isEmpty {
            UIAlertController.showConfirmAlertFromTopViewController(message: "You just said \(text)")
        }
    }
    
    private func handleCustomUI(response: UNNotificationResponse) {
        print(response.actionIdentifier)
    }
}

