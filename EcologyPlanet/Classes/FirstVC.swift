//
//  FirstVC.swift
//  TB
//
//  Created by dzc on 2020/8/10.
//  Copyright © 2020 PHJTYTJ-0003. All rights reserved.
//

import UIKit

class FirstVC: BaseViewController {

    lazy var btn: UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect(x: 100, y: 100, width: 100, height: 40)
        button.setTitle("detailVC", for: .normal)
        button.addTarget(self, action: #selector(clickBtn(bt:)), for: .touchUpInside)
        button.setTitleColor(.red, for: .normal)
        button.tag = 100
        return button
        
    }()
    lazy var btn2: UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect(x: 100, y: 200, width: 100, height: 40)
        button.setTitle("callBackVC", for: .normal)
        button.addTarget(self, action: #selector(clickBtn(bt:)), for: .touchUpInside)
        button.setTitleColor(.red, for: .normal)
        button.tag = 200
        return button
        
    }()
    lazy var btn3: UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect(x: 100, y: 600, width: 100, height: 40)
        button.setTitle("xxxx", for: .normal)
        button.addTarget(self, action: #selector(clickBtn(bt:)), for: .touchUpInside)
        button.setTitleColor(.red, for: .normal)
        button.tag = 300
        return button
        
    }()
    lazy var contentLabel: UILabel = {
        var label = UILabel.init()
        label.backgroundColor = .green
        label.textColor = .gray
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    lazy var uiimagev: UIImageView = {
        var label = UIImageView()
        label.frame = CGRect(x: 100, y: 200, width: 300, height: 300)
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        
        view.addSubview(btn)
        view.addSubview(btn2)
        view.addSubview(contentLabel)
        view.addSubview(uiimagev)
        view.addSubview(btn3)
//        uiimagev.kf.setImage(with: URL(string: "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3363295869,2467511306&fm=26&gp=0.jpg"))
        uiimagev.setUrl("https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3363295869,2467511306&fm=26&gp=0.jpg",placeHolder: "xxx")
////        Dlog(item: "ss t")
        HttpRequest.requestHandyJson(target: EPAPI.upLoadImage(img: UIImage(named: "111")!)) { (data) in
            Dlog(item: String(data: data, encoding: .utf8))
        } failure: { (_, _) in

        }
        HttpRequest.requestHandyJson(target: EPAPI.rankList(10, 1, 1)) { (data) in
            Dlog(item: String(data: data, encoding: .utf8))
//            self.model3 = LiveHJModel.deserialize(from: String(data: model, encoding: .utf8))

        } failure: { (_, _) in

        }
    
       


       
    }

}

extension FirstVC {

    @objc private func clickBtn(bt: UIButton) {
        switch bt.tag {
        case 100:
            let detail = DetailVC.init()
            detail.handle1 = {
                print("没有参数的回调")
            }
            detail.handle2 = { (param) in
                print(param)
            }
            detail.handdle3 = {(param1,param2) in
                print(param1 + ",第二个参数\(param2)")
            }
            detail.handle4 = {(param) in
                print(param.name!)
                self.contentLabel.text = param.name2 ?? ""
                self.contentLabel.frame = CGRect(x: 100, y: 300, width: 100, height: param.nameHeight)
            }
            detail.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(detail, animated: true)
        case 300:
            EPAlertTool.show(topTitle: "温馨提示", content: "发生的开发商的", cancelTitle: "", okTitile: "确定")
        default:
            break
        }
       
    }
}
