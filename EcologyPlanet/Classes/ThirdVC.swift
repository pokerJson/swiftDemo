//
//  ThirdVC.swift
//  TB
//
//  Created by dzc on 2020/8/10.
//  Copyright © 2020 PHJTYTJ-0003. All rights reserved.
//

import UIKit

class ThirdVC: BaseViewController {

    lazy var btn: UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect(x: 100, y: 100, width: 100, height: 40)
        button.setTitle("基本用法", for: .normal)
        button.addTarget(self, action: #selector(clickBtn(bt:)), for: .touchUpInside)
        button.setTitleColor(.red, for: .normal)
        button.tag = 100
        return button
        
    }()
    lazy var btn1: UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect(x: 100, y: 200, width: 100, height: 40)
        button.setTitle("联动用法", for: .normal)
        button.addTarget(self, action: #selector(clickBtn(bt:)), for: .touchUpInside)
        button.setTitleColor(.red, for: .normal)
        button.tag = 100
        return button
        
    }()
    lazy var btn2: UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect(x: 100, y: 400, width: 100, height: 40)
        button.setTitle("炸裂用法", for: .normal)
        button.addTarget(self, action: #selector(clickBtn(bt:)), for: .touchUpInside)
        button.setTitleColor(.red, for: .normal)
        button.tag = 200
        return button
        
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(btn)
        view.addSubview(btn1)
        view.addSubview(btn2)
    }
    

    @objc func clickBtn(bt: UIButton) {
        switch bt.tag {
        case 100:
            let page = PageViewVC()
            page.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(page, animated: true)
        default:
            let page = ZhalieVC()
            page.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(page, animated: true)
        }
        
        
    }
   

}
