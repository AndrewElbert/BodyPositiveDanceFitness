//
//  NotificationsManager.swift
//  BodyPositiveZumba
//
//  Created by Andrew Elbert on 2/16/25.
//

import UserNotifications

class NotificationManager {
    
    static let shared = NotificationManager()
    
    public init() {}
    
    func requestPermissions() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
                print("Notification permissions granted")
            } else if let error = error {
                print("Error requesting notification permissions: \(error.localizedDescription)")
            }
        }
    }
    
    func verifyNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            print("Notification settings:")
            print("Authorization status: \(settings.authorizationStatus.rawValue)")
            print("Alert setting: \(settings.alertSetting.rawValue)")
            print("Sound setting: \(settings.soundSetting.rawValue)")
            print("Badge setting: \(settings.badgeSetting.rawValue)")
        }
    }
    
    func scheduleWeeklySundayNotification() {
        let content = UNMutableNotificationContent()
        content.title = "New Week, New Moves! 💃🕺"
        content.body = "A new week means a new chance to dance! Check out our upcoming classes and let's keep moving together!!"
        content.sound = .defaultCritical
        
        var dateComponents = DateComponents()
        dateComponents.weekday = 1
        dateComponents.hour = 17
        dateComponents.minute = 0
        dateComponents.timeZone = TimeZone(identifier: "America/New_York")
        
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: dateComponents,
            repeats: true
        )
        
        let request = UNNotificationRequest(
            identifier: "weekly-sunday-reminder",
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling weekly notification: \(error.localizedDescription)")
            }
        }
    }
    
    func scheduleTuesdayNightNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Turn Up Your Tuesday! 🎶"
        content.body = "Long week? Shake off the stress and spice up your night with a class you’ll love! 💃🔥"
        content.sound = .defaultCritical

        var dateComponents = DateComponents()
        dateComponents.weekday = 3
        dateComponents.hour = 19
        dateComponents.minute = 0
        dateComponents.timeZone = TimeZone(identifier: "America/New_York")

        let trigger = UNCalendarNotificationTrigger(
            dateMatching: dateComponents,
            repeats: true
        )

        let request = UNNotificationRequest(
            identifier: "weekly-tuesday-reminder",
            content: content,
            trigger: trigger
        )

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling Tuesday notification: \(error.localizedDescription)")
            }
        }
    }
    
    func scheduleFridayEveningNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Feel-Good Friday! 🎊"
        content.body = "Kick off the weekend with some moves! 🎶 Come celebrate the end of the week — let’s dance! 💃✨"
        content.sound = .defaultCritical

        var dateComponents = DateComponents()
        dateComponents.weekday = 6
        dateComponents.hour = 17
        dateComponents.minute = 0
        dateComponents.timeZone = TimeZone(identifier: "America/New_York")

        let trigger = UNCalendarNotificationTrigger(
            dateMatching: dateComponents,
            repeats: true
        )

        let request = UNNotificationRequest(
            identifier: "weekly-friday-reminder",
            content: content,
            trigger: trigger
        )

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling Friday notification: \(error.localizedDescription)")
            }
        }
    }

    
    func scheduleAllNotifications() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            self.scheduleWeeklySundayNotification()
            self.scheduleTuesdayNightNotification()
            self.scheduleFridayEveningNotification()
        }
    }
}
