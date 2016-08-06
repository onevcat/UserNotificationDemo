//
//  AppDelegate.swift
//  UserNotificationDemo
//
//  Created by WANG WEI on 2016/08/02.
//  Copyright © 2016年 OneV's Den. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let notificationHandler = NotificationHandler()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        registerNotificationCategory()
        UNUserNotificationCenter.current().delegate = notificationHandler
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenString = deviceToken.hexString
        UserDefaults.standard.set(tokenString, forKey: "push-token")
        NotificationCenter.default.post(name: .AppDidReceivedRemoteNotificationDeviceToken, object: nil, userInfo: [Notification.Key.AppDidReceivedRemoteNotificationDeviceTokenKey: tokenString])
        
        print("Get Push token: \(tokenString)")
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        UserDefaults.standard.set("", forKey: "push-token")
    }
    
    private func registerNotificationCategory() {
        
        let saySomethingCategory: UNNotificationCategory = {
            
            let inputAction = UNTextInputNotificationAction(
                identifier: SaySomethingCategoryAction.input.rawValue,
                title: "Input",
                options: [.foreground],
                textInputButtonTitle: "Send",
                textInputPlaceholder: "What do you want to say...")
            
            let goodbyeAction = UNNotificationAction(
                identifier: SaySomethingCategoryAction.goodbye.rawValue,
                title: "Goodbye",
                options: [.foreground])
            
            let cancelAction = UNNotificationAction(
                identifier: SaySomethingCategoryAction.none.rawValue,
                title: "Cancel",
                options: [.destructive])
        
            return UNNotificationCategory(identifier: UserNotificationCategoryType.saySomething.rawValue, actions: [inputAction, goodbyeAction, cancelAction], intentIdentifiers: [], options: [.customDismissAction])
        }()
        
        let customUICategory: UNNotificationCategory = {
            let nextAction = UNNotificationAction(
                identifier: CustomizeUICategoryAction.switch.rawValue,
                title: "Switch",
                options: [])
            let openAction = UNNotificationAction(
                identifier: CustomizeUICategoryAction.open.rawValue,
                title: "Open",
                options: [.foreground])
            let dismissAction = UNNotificationAction(
                identifier: CustomizeUICategoryAction.dismiss.rawValue,
                title: "Dismiss",
                options: [.destructive])
            return UNNotificationCategory(identifier: UserNotificationCategoryType.customUI.rawValue, actions: [nextAction, openAction, dismissAction], intentIdentifiers: [], options: [])
        }()
        
        UNUserNotificationCenter.current().setNotificationCategories([saySomethingCategory, customUICategory])
    }

}

extension Notification.Name {
    static let AppDidReceivedRemoteNotificationDeviceToken = Notification.Name(rawValue: "com.onevcat.usernotification.AppDidReceivedRemoteNotificationDeviceToken")
}

extension Notification {
    struct Key {
        static let AppDidReceivedRemoteNotificationDeviceTokenKey = "token"
    }
}

extension Data {
    var hexString: String {
        return withUnsafeBytes {(bytes: UnsafePointer<UInt8>) -> String in
            let buffer = UnsafeBufferPointer(start: bytes, count: count)
            return buffer.map {String(format: "%02hhx", $0)}.reduce("", { $0 + $1 })
        }
    }
}
