//
//  FourthVC.swift
//  TB
//
//  Created by dzc on 2020/8/10.
//  Copyright © 2020 PHJTYTJ-0003. All rights reserved.
//

import UIKit

class FourthVC: BaseViewController {
    
    lazy var content: UILabel = {
        let result = UILabel()
        result.isUserInteractionEnabled = true
        result.frame = CGRect(x: 100, y: 300, width: 300, height: 40)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapp(tap:)))
        result.addGestureRecognizer(tap)
        return result
        
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(content)
        
        
        let bt: UIButton = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 40))
        bt.setTitle("获取", for: .normal)
        bt.setTitleColor(UIColor.red, for: .normal)
        bt.addTarget(self, action: #selector(getInfo), for: .touchUpInside)
        view.addSubview(bt)
        
        //保存用户信息 归档
        let user = EPUserInfo.instance
        user.token = "dfasdfasdf"
        user.userName = "xxxxx"
        user.userID = "111111111"
        user.age = 20
        user.sex = 1
        EPUserInfo.archivedData(info: user)
        
        //
       
        let str = "#发顺丰第三方#阿飞洒发撒的发生的发送到发送到发送到发"
        
        content.attributedText = String.changeToRichText(content: str, tapText: "#发顺丰第三方#", tapColor: "#4F8CBF")
                       
    }
    @objc func getInfo(){
        
    }
    @objc func tapp(tap: UITapGestureRecognizer){
        tap.didTapAttributedTextIn(label: content, tapTexts: ["#发顺丰第三方#"]) { (str, index) in
            print("str="+str)
        }
    }
}

