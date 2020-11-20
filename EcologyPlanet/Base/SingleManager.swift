//
//  SingleManager.swift
//  TB
//
//  Created by dzc on 2020/8/12.
//  Copyright © 2020 PHJTYTJ-0003. All rights reserved.
//

import UIKit
//单利
class SingleManager: NSObject {

    //属性
    var baseTabBarController: MainViewController!
    
    static let shared: SingleManager = {
        let instance = SingleManager()
        let appDe: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        instance.baseTabBarController = (appDe.window?.rootViewController as! MainViewController)
        return instance
    } ()
    
    private override init() {}
}
