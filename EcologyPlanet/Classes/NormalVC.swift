//
//  NormalVC.swift
//  EcologyPlanet
//
//  Created by dzc on 2020/11/20.
//

import UIKit

class NormalVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //常规用法
        let style = EPPageStyle()
        style.labelLayout = .center
        style.isFixedLineWidth = false//是否固定line的宽度 这个等级最高，设置为true其他的设置无效bottomAlginLabel
        
        let pageView = EPPageView(frame: CGRect(x: 0, y: 88, width: SCREEN_WIDTH, height: SCREENT_HEIGHT-88),
                                  titles: ["推是荐","关方法注","视发到频","蓝鸟"],
                                  childControllers: [TestVC(),TestVC(),TestVC(),TestVC()],
                                  parentController: self,style: style)
        view.addSubview(pageView)
        
    }
    

    

}
