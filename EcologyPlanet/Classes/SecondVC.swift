//
//  SecondVC.swift
//  TB
//
//  Created by dzc on 2020/8/10.
//  Copyright © 2020 PHJTYTJ-0003. All rights reserved.
//

import UIKit

class SecondVC: BaseViewController {

    lazy var btn: UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect(x: 100, y: 100, width: 100, height: 40)
        button.setTitle("点击", for: .normal)
        button.addTarget(self, action: #selector(clickBtn), for: .touchUpInside)
        button.setTitleColor(.red, for: .normal)
        return button
    }()
    lazy var startAnimationBtn: UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect(x: 100, y: 200, width: 100, height: 40)
        button.setTitle("开始动画", for: .normal)
        button.addTarget(self, action: #selector(startAnimationBtnClick), for: .touchUpInside)
        button.setTitleColor(.red, for: .normal)
        return button
    }()
    lazy var stopAnimationBtn: UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect(x: 100, y: 300, width: 100, height: 40)
        button.setTitle("结束动画", for: .normal)
        button.addTarget(self, action: #selector(stopAnimationBtnClick), for: .touchUpInside)
        button.setTitleColor(.red, for: .normal)
        return button
    }()
    lazy var snaper: SnaperView = {
        let sn = SnaperView.init(frame: CGRect(x: 10, y: 300, width: 45, height: 45))
        sn.lineWidth = 10
        sn.fillColor = .red
        sn.backgroundColor = .clear
        sn.center = self.view.center
        return sn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        
        view.addSubview(btn)
        view.addSubview(startAnimationBtn)
        view.addSubview(stopAnimationBtn)
        view.addSubview(snaper)
        snaper.startAnmation()
        
        //延迟执行 动画消失
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+3) {
            self.snaper.stopAnimation()
//            self.snaper.removeFromSuperview()
        }
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        Dlog(item: EPUserInfo.instance.userID)

    }
}
extension SecondVC {
    @objc private func clickBtn(){
        SingleManager.shared.baseTabBarController.itemIndex(index: 0, badgeCount: "19")
    }
    @objc private func startAnimationBtnClick() {
        snaper.startAnmation()
    }
    @objc private func stopAnimationBtnClick() {
        snaper.stopAnimation()
    }
}


class SnaperView: UIView {
    
    var isAnimationing: Bool = false
    
    lazy var shaperLayer: CAShapeLayer? = {
        let slayer = CAShapeLayer.init()
        slayer.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
        slayer.fillColor = nil
        slayer.lineWidth = 1
        return slayer
    }()
    var lineWidth: CGFloat?{
        didSet{
            shaperLayer?.lineWidth = lineWidth ?? 1
            let center = CGPoint(x: bounds.width/2, y: bounds.height/2)
            let radius = min(bounds.width/2, bounds.height/2) - shaperLayer!.lineWidth/2
            let startAngle = 0
            let endAngle = Double.pi * 2
            let path = UIBezierPath.init(arcCenter: center, radius: radius, startAngle: CGFloat(startAngle), endAngle: CGFloat(endAngle), clockwise: true)
            shaperLayer?.path = path.cgPath
            shaperLayer?.strokeStart = 0
            shaperLayer?.strokeEnd = 0

        }
    }
    var fillColor: UIColor?{
        didSet{
            shaperLayer?.strokeColor = fillColor?.cgColor ?? UIColor.white.cgColor
        }
    }
    fileprivate func startAnmation() {
        guard isAnimationing == false else {
            print("已经在动画")
            return
        }
        isAnimationing = true
        
        let a1 = CABasicAnimation.init()
        a1.keyPath = "transform.rotation"
        a1.duration = 1.5 / 0.375
        a1.fromValue = 0
        a1.toValue = Double.pi * 2
        a1.repeatCount = HUGE
        a1.isRemovedOnCompletion = false
        shaperLayer?.add(a1, forKey: "view_rotation")
        
        let a2 = CABasicAnimation.init()
        a2.keyPath = "strokeStart"
        a2.duration = 1.5 / 1.5
        a2.fromValue = 0
        a2.toValue = 0.25
        a2.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        
        let a3 = CABasicAnimation.init()
        a3.keyPath = "strokeEnd"
        a3.duration = 1.5 / 1.5
        a3.fromValue = 0
        a3.toValue = 1
        a3.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
     
        let a4 = CABasicAnimation.init()
        a4.keyPath = "strokeStart"
        a4.beginTime = 1.5 / 1.5
        a4.duration = 1.5 / 3
        a4.fromValue = 0.25
        a4.toValue = 1
        a4.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        
        let a5 = CABasicAnimation.init()
        a5.keyPath = "strokeEnd"
        a5.beginTime = 1.5 / 1.5
        a5.duration = 1.5 / 3
        a5.fromValue = 1
        a5.toValue = 1
        a5.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        
        let grroup = CAAnimationGroup()
        grroup.duration = 1.5
        grroup.animations = [a2,a3,a4,a5]
        grroup.repeatCount = HUGE
        grroup.isRemovedOnCompletion = false
        shaperLayer?.add(grroup, forKey: "view_stroke")
        
    }
    fileprivate func stopAnimation() {
        guard isAnimationing == true else {
            print("已经停止动画")
            return
        }
        isAnimationing = false
        
        shaperLayer?.removeAnimation(forKey: "view_rotation")//旋转的
        shaperLayer?.removeAnimation(forKey: "view_stroke")//进度的
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.addSublayer(shaperLayer!)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
