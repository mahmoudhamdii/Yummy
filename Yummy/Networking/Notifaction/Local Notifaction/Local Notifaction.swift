//
//  Local Notifaction.swift
//  Yummy
//
//  Created by hamdi on 14/03/2023.
//

import Foundation
import UserNotifications
import UIKit
class LocalNotifaction {
    static func  firstCouponNotifaction (userName:String){
        let content = UNMutableNotificationContent()
        content.title = "Welcome,\(userName)"
        content.subtitle = "Yummy50"
        content.body = "Enjoy our Delicious dishes and get 50% Off for your first Order 🥳 "
        content.sound = .default
        content.badge = 1
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(1), repeats: false)
        let request = UNNotificationRequest(identifier: "ID1", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
        
        
    }
}
