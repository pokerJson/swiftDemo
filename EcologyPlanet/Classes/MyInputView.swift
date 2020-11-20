//
//  MyInputView.swift
//  TB
//
//  Created by dzc on 2020/8/19.
//  Copyright © 2020 PHJTYTJ-0003. All rights reserved.
//

import UIKit

class MyInputView: UIView {

    let KScreen_Wdith = UIScreen.main.bounds.size.width
    let KScreen_Height = UIScreen.main.bounds.size.height
    let normalHeight:CGFloat = 50.0
    
    var topView: UIView!
    var inputTextFiled: UITextField!
    var moreBtn: UIButton!
    var menuView: UIView!
    
    
    private func initUI() {
        topView = UIView.init(frame: CGRect(x: 0, y: 0, width: KScreen_Wdith, height: normalHeight))
        topView.backgroundColor = .gray
        addSubview(topView)
        
//        inputTextFiled = UITextField.init(frame: CGRect(x: 10, y: 5, width: <#T##CGFloat#>, height: <#T##CGFloat#>))
    }
    
    override init(frame: CGRect) {
        super.init(frame:frame)
    }
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
extension MyInputView {
    
}
