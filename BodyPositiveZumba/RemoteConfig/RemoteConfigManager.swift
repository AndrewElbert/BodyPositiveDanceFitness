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
        settings.minimumFetchInterval = 8*60*60
        remoteConfig.configSettings = settings
        
        let defaults: [String: Any] = [
            "death_screen_enabled": false
        ]
        remoteConfig.setDefaults(defaults as? [String: NSObject])
    }
    
    func fetchRemoteValues(completion: @escaping (Bool) -> Void) {
        print("Fetching remote config...")
        remoteConfig.fetch { [weak self] status, error in
            if let error = error {
                print("Remote config fetch error: \(error.localizedDescription)")
                completion(false)
                return
            }
            
            if status == .success {
                print("Remote config fetch successful")
                self?.remoteConfig.activate { changed, error in
                    if let error = error {
                        print("Remote config activation error: \(error.localizedDescription)")
                        completion(false)
                        return
                    }
                    print("Remote config activated, values changed: \(changed)")
                }
            } else {
                print("Remote config fetch failed with status: \(status)")
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
        let value = getBoolValue(forKey: "death_screen_enabled")
        return value
    }
}
