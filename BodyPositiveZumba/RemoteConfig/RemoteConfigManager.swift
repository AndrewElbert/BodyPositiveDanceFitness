//
//  RemoteConfigManager.swift
//  RemoteConfig
//
//  Created by Andrew Elbert on 2/15/25.
//


// MARK: Firebase Implementation

//import FirebaseRemoteConfig
//
//class RemoteConfigManager {
//    static let shared = RemoteConfigManager()
//    private let remoteConfig = RemoteConfig.remoteConfig()
//
//    private init() {
//
//        let settings = RemoteConfigSettings()
//        settings.minimumFetchInterval = 8*60*60
//        remoteConfig.configSettings = settings
//
//        let defaults: [String: Any] = [
//            "death_screen_enabled": false
//        ]
//        remoteConfig.setDefaults(defaults as? [String: NSObject])
//    }
//
//    func fetchRemoteValues(completion: @escaping (Bool) -> Void) {
//        print("Fetching and activating remote config...")
//
//        remoteConfig.fetchAndActivate { status, error in
//            if let error = error {
//                print("Remote config fetchAndActivate error: \(error.localizedDescription)")
//                completion(false)
//                return
//            }
//
//            switch status {
//            case .successFetchedFromRemote:
//                print("Remote config fetched and activated from server.")
//                completion(true)
//            case .successUsingPreFetchedData:
//                print("Using previously fetched remote config values.")
//                completion(true)
//            default:
//                print("Remote config fetchAndActivate failed with status: \(status)")
//                completion(false)
//            }
//        }
//    }
//
//    func getStringValue(forKey key: String) -> String {
//        return remoteConfig.configValue(forKey: key).stringValue
//    }
//
//    func getBoolValue(forKey key: String) -> Bool {
//        return remoteConfig.configValue(forKey: key).boolValue
//    }
//
//    func getDeathScreenEnabled() -> Bool {
//        let value = getBoolValue(forKey: "death_screen_enabled")
//        return value
//    }
//}
