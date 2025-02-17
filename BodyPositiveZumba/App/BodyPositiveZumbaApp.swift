//
//  BodyPositiveZumbaApp.swift
//  App
//
//  Created by Andrew Elbert on 1/26/25.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct BodyPositiveZumbaApp: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    init() {
            NotificationManager.shared.requestPermissions()
    }

    var body: some Scene {
        WindowGroup {
            InitialLoadRootCoordinatorView()
        }
    }
}
