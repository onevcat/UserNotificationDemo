//
//  Delay.swift
//  UserNotificationDemo
//
//  Created by WANG WEI on 2016/08/03.
//  Copyright © 2016年 OneV's Den. All rights reserved.
//

import Foundation

func delay(_ timeInterval: TimeInterval, _ block: @escaping ()->Void) {
    let after = DispatchTime.now() + timeInterval
    DispatchQueue.main.asyncAfter(deadline: after, execute: block)
}
