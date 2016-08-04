//
//  AuthorizationViewController.swift
//  UserNotificationDemo
//
//  Created by WANG WEI on 2016/08/02.
//  Copyright © 2016年 OneV's Den. All rights reserved.
//

import UIKit
import UserNotifications

class AuthorizationViewController: UIViewController {

    @IBOutlet weak var deviceTokenLabel: UILabel!
    
    @IBOutlet weak var settingsView: UIStackView!
    
    @IBOutlet weak var notificationCenterSettingLabel: UILabel!
    @IBOutlet weak var soundSettingLabel: UILabel!
    @IBOutlet weak var badgeSettingLabel: UILabel!
    @IBOutlet weak var lockScreenSettingLabel: UILabel!
    @IBOutlet weak var alertSettingLabel: UILabel!
    @IBOutlet weak var carPlaySettingLabel: UILabel!
    @IBOutlet weak var alertStyleSettingLabel: UILabel!
    
    var deviceToken: String? {
        didSet {
            if isViewLoaded {
                updateUI()
            }
        }
    }
    var settings: UNNotificationSettings? {
        didSet {
            if isViewLoaded {
                updateUI()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        updateUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(updateSettings), name: .UIApplicationWillEnterForeground, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateNotificationToken), name: .AppDidReceivedRemoteNotificationDeviceToken, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
        super.viewDidDisappear(animated)
    }
    
    @objc private func updateSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { self.settings = $0 }
    }
    
    @objc private func updateNotificationToken(notification: Notification) {
        let tokenKey = Notification.Key.AppDidReceivedRemoteNotificationDeviceTokenKey
        self.deviceToken = notification.userInfo?[tokenKey] as? String
    }
    
    private func updateUI() {
        deviceTokenLabel.text = deviceToken
        
        guard let settings = settings else {
            settingsView.isHidden = true
            return
        }
        
        settingsView.isHidden = false
        notificationCenterSettingLabel.text = settings.notificationCenterSetting.description
        soundSettingLabel.text = settings.soundSetting.description
        badgeSettingLabel.text = settings.badgeSetting.description
        lockScreenSettingLabel.text = settings.lockScreenSetting.description
        alertSettingLabel.text = settings.alertSetting.description
        carPlaySettingLabel.text = settings.carPlaySetting.description
        alertStyleSettingLabel.text = settings.alertStyle.description
    }

    @IBAction func requestButtonPressed(_ sender: AnyObject) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
            granted, error in
            if granted {
                UIApplication.shared.registerForRemoteNotifications()
            } else {
                if let error = error {
                    UIAlertController.showConfirmAlert(message: error.localizedDescription, in: self)
                }
            }
        }
    }
}

extension UNNotificationSetting: CustomStringConvertible {
    public var description: String {
        switch self {
        case .notSupported: return "Not Supported"
        case .disabled: return "Disabled"
        case .enabled: return "Enabeld"
        }
    }
}

extension UNAlertStyle: CustomStringConvertible {
    public var description: String {
        switch self {
        case .alert: return "Alert"
        case .banner: return "Banner"
        case .none: return "None"
        }
    }
}
