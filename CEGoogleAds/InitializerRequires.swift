//
//  InitializerRequires.swift
//  CEGoogleAds
//
//  Created by Çağatay Emekci on 22.03.2020.
//  Copyright © 2020 Çağatay Emekci. All rights reserved.
//

import Foundation
import GoogleMobileAds
struct Preferences: Codable {
    var GADApplicationIdentifier:String
}

class InitializerRequires {
    var applicationIdentifier: String?
    init(applicationIdentifier: String) {
        self.applicationIdentifier = applicationIdentifier
        addInfoPlist()
    }
    
    func start() {
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        GADMobileAds.sharedInstance().requestConfiguration.testDeviceIdentifiers = [ "3eb510a6231cad7993ac68d8ce11ef78" ]
    }
    
    func addInfoPlist() {
        guard let id = applicationIdentifier else {return}
        let preferences = Preferences(GADApplicationIdentifier: id)
        
        let encoder = PropertyListEncoder()
        encoder.outputFormat = .xml

        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("Info.plist")

        do {
            let data = try encoder.encode(preferences)
            try data.write(to: path)
        } catch {
            print(error)
        }
    }
    
    
}
