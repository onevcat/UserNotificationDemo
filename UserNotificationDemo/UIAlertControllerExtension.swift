//
//  UIAlertExtension.swift
//  UserNotificationDemo
//
//  Created by WANG WEI on 2016/08/03.
//  Copyright © 2016年 OneV's Den. All rights reserved.
//

import UIKit

extension UIAlertController {
    static func showConfirmAlert(message: String, in viewController: UIViewController) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        viewController.present(alert, animated: true)
    }
}
