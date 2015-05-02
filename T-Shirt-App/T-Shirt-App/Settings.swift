//
//  Settings.swift
//  T-Shirt-App
//
//  Created by Gunnar Wrobel on 02.05.15.
//  Copyright (c) 2015 Gunnar Wrobel. All rights reserved.
//

import Foundation

class Settings {
    
    private let settingsFileName = "Settings"
    private let settingsOverrideFileName = "SettingsOverride"

    private func dataFilePath() -> String {
        if let override = NSBundle.mainBundle().pathForResource(settingsOverrideFileName, ofType:"plist") {
            return override
        }
        return NSBundle.mainBundle().pathForResource(settingsFileName, ofType:"plist")!
    }

    func get(key: String) -> String {
        let plist = NSDictionary(contentsOfFile: dataFilePath())
        
        let value = plist?.objectForKey(key) as! String
        return value
    }
    
    func backendUrl() -> String {
        return get("BackendUrl")
    }

}