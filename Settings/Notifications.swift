//
//  Notifications.swift
//  Settings
//
//  Created by Roman on 12.01.2022.
//

import Foundation
import UserNotifications

// Уведомления
extension MainViewController: UNUserNotificationCenterDelegate{

    // Запрос доступа
    func askAccess() {
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]){(granted, error)
            in
            guard granted else { return }
            self.notificationCenter.getNotificationSettings { (settings) in
                guard settings.authorizationStatus == .authorized else { return }
            }
        }
        notificationCenter.delegate = self
    }

    // Вывод уведомления
    func sendNotification(title: String){
        let content = UNMutableNotificationContent()
        content.title = title
        //content.body = body
        content.sound = UNNotificationSound.default

        let request = UNNotificationRequest(identifier: "Notification", content: content, trigger: .none)
        notificationCenter.add(request){ (error) in
            //print(error?.localizedDescription)
        }
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.sound, .banner])
    }

    // Срабатывание при нажатии на уведомление
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print(#function)
    }
}

