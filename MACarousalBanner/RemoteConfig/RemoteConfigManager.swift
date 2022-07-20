//
//  RemoteConfigManager.swift
//  MACarousalBanner
//
//  Created by Alam, Mahjabin | ECMPD on R 4/07/19.
//

import Foundation
import FirebaseCore
import FirebaseRemoteConfig

protocol RemoteConfigManagerProtocol: AnyObject {
    func didReiceveValues(_ response: RemoteConfigResponse?)
}

class RemoteConfigManager {
    
    private let firebaseRemote: RemoteConfig
    
    weak var delegate: RemoteConfigManagerProtocol?
    
    init(remoteConfig: RemoteConfig = RemoteConfig.remoteConfig()) {
        firebaseRemote = remoteConfig
    }
    
    func getValue(forKey key: String) -> String? {
        return firebaseRemote.configValue(forKey: key).stringValue
    }
    
    func getResponse() {
        let imagePattern = getValue(forKey: "pattern")
        let remoteConfigResponse = RemoteConfigResponse(arrowPattern: imagePattern)
        delegate?.didReiceveValues(remoteConfigResponse)
    }

    func fetchRemoteConfigValues() {
        firebaseRemote.configSettings = settingsWithDeveloperMode()
        firebaseRemote.fetch(withExpirationDuration: 1.0) { status, error in
            if let error = error {
                print("error while fetching \(error.localizedDescription) for status \(status)")
                return
            }
            self.firebaseRemote.activate { _, error in
                if let error = error {
                    print("error while activating \(error.localizedDescription)")
                    return
                } else {
                    self.getResponse()
                }
            }
        }
    }
}

// MARK: - Utility methods

extension RemoteConfigManager {
    
    func settingsWithDeveloperMode() -> RemoteConfigSettings {
        let debugSettings = RemoteConfigSettings()
        debugSettings.minimumFetchInterval = 1.0
        return debugSettings
    }
}
