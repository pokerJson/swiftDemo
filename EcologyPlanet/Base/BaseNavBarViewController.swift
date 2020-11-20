//
//  BaseNavBarViewController.swift
//  nnnnnnnnnnnn
//
//  Created by dzc on 2020/8/4.
//  Copyright © 2020 PHJTYTJ-0003. All rights reserved.
//

import UIKit

/// 全屏手势
class BaseNavBarViewController: UINavigationController,UIGestureRecognizerDelegate {
    
    private var pan: UIPanGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        addFullScreenPopPanGesture()
    }
    
   
}
extension BaseNavBarViewController {
    
    func addFullScreenPopPanGesture() {
        pan = UIPanGestureRecognizer.init(target: self.interactivePopGestureRecognizer?.delegate, action: Selector(("handleNavigationTransition:")))
        pan.delegate = self;
        view.addGestureRecognizer(pan)
        self.interactivePopGestureRecognizer?.delegate = self
        self.interactivePopGestureRecognizer?.require(toFail: pan)
    }
    
    internal func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard gestureRecognizer.isEqual(pan) else {
            print("手势失败")
            return false
        }
        let translationPoint = pan.translation(in: view)
        guard translationPoint.x > 0 && viewControllers.count > 1 else {
            print("手势方向不对或者vc数量小于2")
            return false
        }
        return true
    }

}

