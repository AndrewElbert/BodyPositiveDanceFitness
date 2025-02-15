//
//  RemoteConfigProtocol.swift
//  RemoteConfig
//
//  Created by Andrew Elbert on 2/15/25.
//

protocol RemoteConfigProtocol {
    func configValue(forKey key: String) -> RemoteConfigValue
}

extension RemoteConfig: RemoteConfigProtocol {}
