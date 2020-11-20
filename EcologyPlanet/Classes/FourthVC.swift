//
//  FourthVC.swift
//  TB
//
//  Created by dzc on 2020/8/10.
//  Copyright © 2020 PHJTYTJ-0003. All rights reserved.
//

import UIKit

class FourthVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .orange
        
        let bt: UIButton = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 40))
        bt.setTitle("获取", for: .normal)
        bt.setTitleColor(UIColor.red, for: .normal)
        bt.addTarget(self, action: #selector(getInfo), for: .touchUpInside)
        view.addSubview(bt)
        
        
        let user = EPUserInfo.instance
        user.token = "dfasdfasdf"
        user.userName = "xxxxx"
        user.userID = "111111111"
        user.age = 20
        user.sex = 1
        EPUserInfo.archivedData(info: user)
        
    }
    @objc func getInfo(){

    }

}
