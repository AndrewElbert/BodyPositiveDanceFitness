//
//  RemoteConfigManager.swift
//  RemoteConfig
//
//  Created by Andrew Elbert on 2/15/25.
//

import FirebaseRemoteConfig

class RemoteConfigManager {
    static let shared = RemoteConfigManager()
    private let remoteConfig = RemoteConfig.remoteConfig()

    private init() {
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 12 * 60 * 60
        remoteConfig.configSettings = settings
    }

    func fetchRemoteValues(completion: @escaping (Bool) -> Void) {
        remoteConfig.fetch { status, _ in
            if status == .success {
                self.remoteConfig.activate { _, _ in
                    completion(true)
                }
            } else {
                completion(false)
            }
        }
    }

    func getStringValue(forKey key: String) -> String {
        return remoteConfig.configValue(forKey: key).stringValue
    }

    func getBoolValue(forKey key: String) -> Bool {
        return remoteConfig.configValue(forKey: key).boolValue
    }
    
    func getDeathScreenEnabled() -> Bool {
            return getBoolValue(forKey: "death_screen_enabled")
        }
}
