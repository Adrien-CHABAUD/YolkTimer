//
//  NotificationHandler.swift
//  YolkTimer
//
//  Created by Adrien CHABAUD on 2024-05-13.
//

import Foundation
import UserNotifications

class NotificationHandler {
    func askPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge,.sound]) { success, error in
            if success {
                print("Access Granted")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func sendNotification(timeInterval: Double = 10, title: String, body: String, uuidString: String) {
        var trigger: UNNotificationTrigger?
        
        trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default
        
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    func cancelNotification(uuidString: String) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [uuidString])
    }
}
