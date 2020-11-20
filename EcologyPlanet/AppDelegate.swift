//
//  AppDelegate.swift
//  EcologyPlanet
//
//  Created by dzc on 2020/11/13.
//

import UIKit
import Reachability

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    
    var window: UIWindow?
    var reach: Reachability?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.rootViewController = MainViewController.init()
        window?.makeKeyAndVisible()
        
        //网络检测
        self.reach = Reachability.forInternetConnection()
        Dlog(item: self.reach?.isReachableViaWiFi())
        self.reach!.reachableBlock = {
            (reach: Reachability?) -> Void in
            DispatchQueue.main.async {
                print("网络可用!")
            }
        }
        self.reach!.unreachableBlock = {
            (reach: Reachability?) -> Void in
            print("网络不可用!")
        }
        self.reach!.startNotifier()
        
        
        //入口请求下用户信息
        EPUserInfo.getUserInfo()
        Dlog(item: EPUserInfo.instance.userName)
        
        return true
    }
    
    
}

