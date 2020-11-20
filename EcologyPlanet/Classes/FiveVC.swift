//
//  FiveVC.swift
//  TB
//
//  Created by dzc on 2020/8/11.
//  Copyright © 2020 PHJTYTJ-0003. All rights reserved.
//

import UIKit

class FiveVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        let titles: Array<String> = ["闲聊","学友录"]
        let leftVC = TestVC.init()
        let rightVC = TestVC.init()
        for obj in children {
            obj.removeFromParent()
        }
        addChild(leftVC)
        addChild(rightVC)
        
        
        let sv = SwitchiView.init(frame: CGRect(x: 0, y: 84, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-88-83))
        sv.titleArr(titles, loadViewBlock: { (scrollView, index) in
            print("loadView+\(index)")
            scrollView.contentSize = CGSize(width: UIScreen.main.bounds.size.width*2, height: UIScreen.main.bounds.size.height-88-83-44);
            self.children[index].view.frame = CGRect(x: scrollView.bounds.size.width*CGFloat(index), y: 0, width: UIScreen.main.bounds.size.width, height: scrollView.frame.height)
            scrollView.addSubview(self.children[index].view)
        }) { (scrollView, index) in
            print("current+\(index)")
        }
        view.addSubview(sv)
        
    }
    

   

}
