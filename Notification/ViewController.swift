//
//  ViewController.swift
//  Notification
//
//  Created by Dominika Poleshyck on 1.11.21.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let center = UNUserNotificationCenter.current()
        center.delegate = self
                center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
                    if granted {
                        print("Yay!")
                    } else {
                        print("D'oh")
                    }
                }
        // Do any additional setup after loading the view.
    }
    @IBAction private func pushNotification() {
        let center = UNUserNotificationCenter.current()

            let content = UNMutableNotificationContent()
            content.title = "Late wake up call"
            content.body = "The early bird catches the worm, but the second mouse gets the cheese."
            content.categoryIdentifier = "alarm"
            content.userInfo = ["customData": "fizzbuzz"]
            content.sound = UNNotificationSound.default
        let action = UNTextInputNotificationAction(identifier: "123", title: "start", options: .foreground, icon: nil)
        let action2 = UNTextInputNotificationAction(identifier: "1232", title: "start", options: .foreground, icon: nil)
        let action3 = UNTextInputNotificationAction(identifier: "12334", title: "start", options: .foreground, icon: nil, textInputButtonTitle: "go", textInputPlaceholder: "placeHolder")
        let category = UNNotificationCategory(identifier: "1234", actions: [action, action2, action3], intentIdentifiers: ["12345"], hiddenPreviewsBodyPlaceholder: nil, categorySummaryFormat: nil, options: .allowInCarPlay)
        center.setNotificationCategories([category])
        var date = DateComponents()
        date.hour = 20
        date.minute = 55
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)

            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
    }

}

extension ViewController: UNUserNotificationCenterDelegate {

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print(response.notification.request.content.userInfo)
        completionHandler()
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }
}
