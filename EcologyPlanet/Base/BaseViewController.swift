//
//  BaseViewController.swift
//  nnnnnnnnnnnn
//
//  Created by dzc on 2020/8/4.
//  Copyright © 2020 PHJTYTJ-0003. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    var scrollEnabled: Bool = false
    var kTableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //禁用系统默认的侧滑手势
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
}
extension BaseViewController {
    //push
    public func push(_ viewController: UIViewController ,animated: Bool) {
        viewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(viewController, animated: animated)
    }
    var kScreenWidth: CGFloat {
        return UIScreen.main.bounds.size.width
    }
    var kScreenHeight: CGFloat {
        return UIScreen.main.bounds.size.height
    }
}
