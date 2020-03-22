//
//  GoogleAdsRewardedView.swift
//  bioquiz
//
//  Created by Çağatay Emekci on 17.02.2020.
//  Copyright © 2020 Çağatay Emekci. All rights reserved.
//

import SwiftUI
import GoogleMobileAds
import UIKit
    
final class GoogleAdsRewardedView: NSObject, GADRewardedAdDelegate{
    var rewardID = "ca-app-pub-3940256099942544/1712485313"
    var rewardedAd:GADRewardedAd = GADRewardedAd(adUnitID: "ca-app-pub-3940256099942544/1712485313")
    var rewardAd = false
    var rewardFunction: (() -> Void)? = nil
    
    override init() {
        super.init()
        loadRewarded()
    }
    
    func loadRewarded(){
        let req = GADRequest()
        self.rewardedAd.load(req)
    }
    
    func showAd(rewardFunction: @escaping () -> Void){
        if self.rewardedAd.isReady{
            self.rewardFunction = rewardFunction
            let root = UIApplication.shared.windows.first?.rootViewController
            self.rewardedAd.present(fromRootViewController: root!, delegate: self)
        }
       else{
           rewardFunction()
       }
    }
    
    func rewardedAd(_ rewardedAd: GADRewardedAd, userDidEarn reward: GADAdReward) {
        self.rewardAd = true
    }
    
    func rewardedAdDidDismiss(_ rewardedAd: GADRewardedAd) {
        self.rewardedAd = GADRewardedAd(adUnitID: rewardID)
        loadRewarded()
        if let rf = rewardFunction, rewardAd {
            rf()
            rewardAd = false
        }
    }
}
