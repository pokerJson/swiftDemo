//
//  DetailVC.swift
//  TB
//
//  Created by dzc on 2020/8/12.
//  Copyright © 2020 PHJTYTJ-0003. All rights reserved.
//

import UIKit

class DetailVC: BaseViewController {

    lazy var btn: UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect(x: 100, y: 100, width: 100, height: 40)
        button.setTitle("点击", for: .normal)
        button.addTarget(self, action: #selector(clickBtn), for: .touchUpInside)
        button.setTitleColor(.red, for: .normal)
        return button
    }()
    lazy var backBtn: UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect(x: 100, y: 200, width: 200, height: 40)
        button.setTitle("返回-闭包传值", for: .normal)
        button.addTarget(self, action: #selector(backBtnClcik), for: .touchUpInside)
        button.setTitleColor(.red, for: .normal)
        return button
    }()
    
    var handle1: HandleNoParam?
    var handle2: HandleSingleParam<String>?
    var handdle3: HandleTwoParam<String,Int>?
    var handle4: HandleSingleParam<Model>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        
        view.addSubview(btn)
        view.addSubview(backBtn)

        
    }
    

}
extension DetailVC {
    @objc private func clickBtn() {
        navigationController?.popViewController(animated: false)
        SingleManager.shared.baseTabBarController.selectedItemIndex(2)
    }
    @objc private func backBtnClcik() {
        navigationController?.popViewController(animated: true)
//        if handle1 != nil {
//            handle1!()
//        }
//        if handle2 != nil {
//            handle2!("单个参数的")
//        }
//        if handdle3 != nil {
//            handdle3!("第一个参数",18)
//        }
        let model: Model = Model.init()
        model.name = "刘德华是打发斯蒂芬撒地方撒旦法撒旦法撒旦法师打发士大夫撒旦发撒旦法撒旦法水电费水电费"
        model.age = 19
        model.address = "地方撒打发斯蒂芬"
        if handle4 != nil {
            handle4!(model)
        }
    }
}

//MARK:类
class Model: NSObject {
    var name:String?
    var age:Int!
    var address: String?
}
extension Model {
    //计算属性 getter
    var name2: String? {
        return (name ?? "张学友") + "今年\(age!)岁"
    }
    var nameHeight: CGFloat {
        
        let paragraphStyle: NSMutableParagraphStyle = NSMutableParagraphStyle.init()
        paragraphStyle.lineSpacing = 5
        var dict: [NSAttributedString.Key:Any] = Dictionary()
        dict[NSAttributedString.Key.font] = UIFont.systemFont(ofSize: 14)
        dict[NSAttributedString.Key.paragraphStyle] = paragraphStyle
        
        let rect: CGRect = (name2 ?? "").boundingRect(with: CGSize(width: 100.0,height: Double(MAXFLOAT)),options: NSStringDrawingOptions.usesLineFragmentOrigin,attributes: dict,context:nil)
        
        return rect.size.height
        
    }
    
}
