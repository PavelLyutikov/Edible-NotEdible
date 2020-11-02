//
//  AddMobile.swift
//  EdibleNotEdible
//
//  Created by mac on 10.05.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import GoogleMobileAds


class AddInterstitial {

    enum AddSEnum: String {
        case testInter = "ca-app-pub-3940256099942544/4411468910"
//        case inter = "ca-app-pub-2129016611376338/3479518422"
        case inter = "ca-app-pub-9265838027738410/1944176525"
        
    }

    var interstitial: GADInterstitial!
    var rewardedAd: GADRewardedAd?

    init(controller: UIViewController) {
        interstitial =  createAndLoadInterstitial(viewController: controller)
        rewardedAd = createAndLoadVideo()
    }

    func createAndLoadVideo() -> GADRewardedAd {
        let rewerdedAd = GADRewardedAd(adUnitID: "ca-app-pub-2719639882869318/1218146191")
        rewardedAd?.load(GADRequest()) { error in
            if error != nil {
            // Handle ad failed to load case.
          } else {
            // Ad successfully loaded.
          }
        }
        return rewerdedAd
    }

    func createAndLoadInterstitial(viewController: UIViewController) -> GADInterstitial {
        let interstitial = GADInterstitial(adUnitID: AddSEnum.inter.rawValue)
        interstitial.delegate = (viewController as! GADInterstitialDelegate)
        interstitial.load(GADRequest())
        return interstitial
    }

}
