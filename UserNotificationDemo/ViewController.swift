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

    @IBOutlet weak var authorizationLabel: UILabel!
    private var settings: UNNotificationSettings?
    
    enum Segue: String {
        case showAuthorization
        case showTimeInterval
        case showTimeIntervalForeground
        case showManagement
        case showActionable
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        UNUserNotificationCenter.current().getNotificationSettings {
            settings in
            if settings.authorizationStatus == .authorized {
                self.authorizationLabel.text = "Authorized"
            }
            self.settings = settings
        }
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
            vc.deviceToken = UserDefaults.standard.object(forKey: "push-token") as? String
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
        case .showActionable: break
        
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: AnyObject?) -> Bool {
        if settings == nil {
            return false
        }
        return true
    }
}

