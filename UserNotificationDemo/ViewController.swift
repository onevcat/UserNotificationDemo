//
//  ViewController.swift
//  UserNotificationDemo
//
//  Created by WANG WEI on 2016/08/02.
//  Copyright © 2016年 OneV's Den. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UITableViewController {

    private var settings: UNNotificationSettings?
    
    enum Segue: String {
        case showAuthorization
        case showTimeInterval
        case showTimeIntervalForeground
        case showManagement
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        UNUserNotificationCenter.current().getNotificationSettings { self.settings = $0 }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        guard let string = segue.identifier, let s = Segue(rawValue: string) else {
            return
        }
        
        switch s {
        case .showAuthorization:
            guard let vc = segue.destination as? AuthorizationViewController else {
                fatalError("The destination should be AuthorizationViewController")
            }
            vc.settings = settings
        case .showTimeInterval:
            guard let vc = segue.destination as? TimeIntervalViewController else {
                fatalError("The destination should be TimeIntervalViewController")
            }
            vc.notificationType = .timeInterval
        case .showTimeIntervalForeground:
            guard let vc = segue.destination as? TimeIntervalViewController else {
                fatalError("The destination should be TimeIntervalViewController")
            }
            vc.notificationType = .timeIntervalForeground
        case .showManagement: break
        
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: AnyObject?) -> Bool {
        if settings == nil {
            return false
        }
        return true
    }
}

