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
import AppTrackingTransparency

@available(iOS 11.0, *)
class GameViewController: UIViewController {
    
    let totalSize = UIScreen.main.bounds.size

    
    var showVideoReward: Bool = false
    
    //ironSource
    let kAPPKEY = "1230817ad"
    var bannerView: ISBannerView! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (timer) in
            if #available(iOS 14.6, *) {
                ATTrackingManager.requestTrackingAuthorization { status in
                    switch status {
                    case .notDetermined:
                        break
                    case .restricted:
                        break
                    case .denied:
                        break
                    case .authorized:
                        print("authorized")
                        break
                    @unknown default:
                        break
                    }
                }
            } else {
                // Fallback on earlier versions
            }
        }
            
        
        NotificationCenter.default.addObserver(self, selector: #selector(GameViewController.presentInterstitial), name: NSNotification.Name(rawValue: "presentInterstitial"), object: nil)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(GameViewController.showRewardVideo), name: NSNotification.Name(rawValue: "showRewardVideo"), object: nil)
        
        setupIronSourceSdk()
        loadBanner()
        loadInterstitial()
    }
    
    func loadInterstitial() {
        IronSource.loadInterstitial()
    }
    func loadBanner() {
        let BNSize: ISBannerSize = ISBannerSize(description: "BANNER", width: 320 , height: 50)
        IronSource.loadBanner(with: self, size: BNSize)
    }
    func setupIronSourceSdk() {
        
        IronSource.setRewardedVideoDelegate(self)
        IronSource.setInterstitialDelegate(self)
        IronSource.setBannerDelegate(self)
        IronSource.add(self)
        
        IronSource.initWithAppKey(kAPPKEY)
    }
    func logFunctionName(string: String = #function) {
        print("IronSource Swift Demo App:"+string)
    }
    func destroyBanner() {
        if bannerView != nil {
            IronSource.destroyBanner(bannerView)
        }
    }
    
        
//MARK: - ShowRewardVideo
    @objc func showRewardVideo() {
        IronSource.showRewardedVideo(with: self)
    }
    
    @objc func presentInterstitial() {
        IronSource.showInterstitial(with: self)
    }
    
    func configureAudioSession() throws {
        try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.ambient)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
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

//MARK: - ExtensionIronSource
extension GameViewController: ISBannerDelegate, ISImpressionDataDelegate, ISInterstitialDelegate, ISRewardedVideoDelegate {
    
    //banner
    func bannerDidLoad(_ bannerView: ISBannerView!) {
        self.bannerView = bannerView
        if #available(iOS 11.0, *) {
               
            if totalSize.height >= 801 {
                bannerView.frame = CGRect(x: 0, y: view.frame.size.height - 50, width: view.frame.size.width, height: 0)
                
            } else if totalSize.height <= 800 {
                bannerView.frame = CGRect(x: 0, y: view.frame.size.height - 50, width: view.frame.size.width, height: 0)
            }
        } else {
                bannerView.frame = CGRect(x: 0, y: view.frame.size.height - 50, width: view.frame.size.width, height: 0)
        }

        bannerView.layer.zPosition = 100
//        view.addSubview(bannerView)
        
        logFunctionName()
    }
    func bannerDidShow() {
        logFunctionName()
    }
    func bannerDidFailToLoadWithError(_ error: Error!) {
        logFunctionName(string: #function+String(describing: Error.self))
    }
    func didClickBanner() {
        logFunctionName()
    }
    func bannerWillPresentScreen() {
        logFunctionName()
    }
    func bannerDidDismissScreen() {
        logFunctionName()
    }
    func bannerWillLeaveApplication() {
        logFunctionName()
    }
    func impressionDataDidSucceed(_ impressionData: ISImpressionData!) {
        logFunctionName(string: #function+String(describing: impressionData))
    }
    
    //Interstitial
    public func didClickInterstitial() {
        logFunctionName()
    }
    public func interstitialDidFailToShowWithError(_ error: Error!) {
        logFunctionName(string: String(describing: error.self))
    }
    public func interstitialDidShow() {
        logFunctionName()
    }
    public func interstitialDidClose() {
        logFunctionName()
    }
    public func interstitialDidOpen() {
        logFunctionName()
    }
    public func interstitialDidFailToLoadWithError(_ error: Error!) {
        logFunctionName(string: #function+String(describing: error.self))
    }
    public func interstitialDidLoad() {
        logFunctionName()
    }
    
    //RewardedVideo
    public func rewardedVideoHasChangedAvailability(_ available: Bool) {
        logFunctionName(string: #function+String(available.self))
    }
    public func rewardedVideoDidEnd() {
        logFunctionName()
    }
    public func rewardedVideoDidStart() {
        logFunctionName()
    }
    public func rewardedVideoDidClose() {
        
        if showVideoReward == true {
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "successfulAdViewing"), object: nil)
            showVideoReward = false
        }
        
        logFunctionName()
    }
    public func rewardedVideoDidOpen() {
        logFunctionName()
    }
    public func rewardedVideoDidFailToShowWithError(_ error: Error!) {
        logFunctionName(string: #function+String(describing: error.self))
    }
    public func didReceiveReward(forPlacement placementInfo: ISPlacementInfo!) {
        logFunctionName(string: #function+String(describing: placementInfo.self))
        
        showVideoReward = true
    }
    func didClickRewardedVideo(_ placementInfo: ISPlacementInfo!) {
        logFunctionName(string: #function+String(describing: placementInfo.self))
    }
}
