//
//  GameViewController.swift
//  EdibleNotEdible
//
//  Created by mac on 18.04.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import GoogleMobileAds
import AVFoundation
import UnityAds
import FBAudienceNetwork
//import YandexMobileAds
//import AppTrackingTransparency
//import Appodeal

@available(iOS 14.0, *)
class GameViewController: UIViewController, FBAdViewDelegate {

    
    
    var bannerFBView: FBAdView!

    var addShowEd = true
    var adds: AddInterstitial!
    
    
    private let banner: GADBannerView = {
        let banner = GADBannerView()
        banner.adUnitID = "ca-app-pub-9265838027738410/3760832838"
//        banner.adUnitID = "ca-app-pub-2129016611376338/8170514429"
//        banner.adUnitID = "ca-app-pub-3940256099942544/2934735716"//Test
        banner.load(GADRequest())
        banner.backgroundColor = .clear
        return banner
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.adds = AddInterstitial(controller: self)
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = MenuScene(fileNamed: "MenuScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            view.ignoresSiblingOrder = true
            
            
        }
            
        
        NotificationCenter.default.addObserver(self, selector: #selector(GameViewController.presentInterstitial), name: NSNotification.Name(rawValue: "presentInterstitial"), object: nil)
        
        banner.rootViewController = self
        view.addSubview(banner)
//        requestIDFA()
//        loadFacebookBanner()
        
        
    }
    
//    func requestIDFA() {
//      ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
//        // Tracking authorization completed. Start loading ads here.
////         loadAd()
//      })
//    }
    
    func loadFacebookBanner() {
        bannerFBView = FBAdView(placementID: "262266858194204_262273364860220", adSize: kFBAdSizeHeight50Banner, rootViewController: self)
        bannerFBView.frame = CGRect(x: 0, y: view.bounds.height - bannerFBView.frame.size.height, width: bannerFBView.frame.size.width, height: bannerFBView.frame.size.height)
        bannerFBView.delegate = self
        bannerFBView.isHidden = true
        self.view.addSubview(bannerFBView)
        bannerFBView.loadAd()
    }
    func adViewDidLoad(_ adView: FBAdView) {
        bannerFBView.isHidden = false
    }
    func adView(_ adView: FBAdView, didFailWithError error: Error) {
        print(error)
    }
    
    @objc func presentInterstitial() {
        if self.adds.interstitial.isReady {
            self.adds.interstitial?.present(fromRootViewController: self)
    } else {
             print("Not ready/ads disabled")
        }
    }
    
    func configureAudioSession() throws {
        try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.ambient)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        banner.frame = CGRect(x: view.frame.midX - 150, y: view.frame.size.height - 50, width: 300/*view.frame.size.width*/, height: 50).integral
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}

@available(iOS 14.0, *)
extension GameViewController: GADInterstitialDelegate {

    // delegates for image

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

    /// Tells the delegate the interstitial had been animated off the screen.
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        adds.interstitial = self.adds.createAndLoadInterstitial(viewController: self)
      print("interstitialDidDismissScreen")
    }

    /// Tells the delegate that a user click will open another app
    /// (such as the App Store), backgrounding the current app.
    func interstitialWillLeaveApplication(_ ad: GADInterstitial) {
      print("interstitialWillLeaveApplication")
    }

}
