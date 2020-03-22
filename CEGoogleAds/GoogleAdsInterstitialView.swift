//
//  GoogleAdsInterstitialView.swift
//  bioquiz
//
//  Created by Çağatay Emekci on 28.01.2020.
//  Copyright © 2020 Çağatay Emekci. All rights reserved.
//

import SwiftUI
import GoogleMobileAds
import UIKit
    
final class GoogleAdsInterstitialView:NSObject{
    var interstitial:GADInterstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
    var rewardFunction: (() -> Void)? = nil
    override init() {
        super.init()
        loadInterstitial()
    }
    
    func loadInterstitial(){
        let req = GADRequest()
        self.interstitial.load(req)
        self.interstitial.delegate = self
    }
    
    func showAd(rewardFunction: @escaping () -> Void){
        if self.interstitial.isReady{
        self.rewardFunction = rewardFunction
           let root = UIApplication.shared.windows.first?.rootViewController
           self.interstitial.present(fromRootViewController: root!)
        }
       else{
            rewardFunction()
       }
    }
}

extension GoogleAdsInterstitialView: GADInterstitialDelegate {
    /// Tells the delegate an ad request succeeded.
    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
      print("interstitialDidReceiveAd")
    }

    /// Tells the delegate an ad request failed.
    func interstitial(_ ad: GADInterstitial, didFailToReceiveAdWithError error: GADRequestError) {
      print("interstitial:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }

    /// Tells the delegate that an interstitial will be presented.
    func interstitialWillPresentScreen(_ ad: GADInterstitial) {
      print("interstitialWillPresentScreen")
    }

    /// Tells the delegate the interstitial is to be animated off the screen.
    func interstitialWillDismissScreen(_ ad: GADInterstitial) {
      print("interstitialWillDismissScreen")
    }

    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        self.interstitial = GADInterstitial(adUnitID: "ca-app-pub-3145502433639725/9019311914")
        loadInterstitial()
        rewardFunction?()
    }

    /// Tells the delegate that a user click will open another app
    /// (such as the App Store), backgrounding the current app.
    func interstitialWillLeaveApplication(_ ad: GADInterstitial) {
      print("interstitialWillLeaveApplication")
    }
}
