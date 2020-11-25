//
//  ZhalieVC.swift
//  EcologyPlanet
//
//  Created by dzc on 2020/11/20.
//

import UIKit

class ZhalieVC: BaseViewController {
    //
    let headerHeight: CGFloat = 200.0
    
    
    lazy var headView: UIView = {
        let result = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: headerHeight))
        result.backgroundColor = .orange
        return result
    }()
    lazy var style: EPPageStyle = {
        let result = EPPageStyle()
        result.labelLayout = .center
        result.isFixedLineWidth = false
        return result
    }()
    var vcs = [LeftVC(),RightVC()]
    lazy var pageView: EPPageView = {
        let result = EPPageView(frame: CGRect(x: 0, y: headerHeight, width: SCREEN_WIDTH, height: SCREENT_HEIGHT-kTABBARH), titles: ["推是荐","视发到频"], childControllers: children, parentController: self, style: self.style)
        return result
    }()
    lazy var sccccc: EPScrollView = {
        let result = EPScrollView(frame: CGRect(x: 0, y: self.kNAVBARH, width: SCREEN_WIDTH, height: SCREENT_HEIGHT))
        result.delegate = self
        result.addSubview(self.headView)
        result.addSubview(self.pageView)
        result.contentSize = CGSize(width: kScreenWidth, height: SCREENT_HEIGHT+headerHeight)
        result.showsVerticalScrollIndicator = false
        result.backgroundColor = .white
        return result
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollEnabled = true
        vcs.forEach { (vc) in
            addChild(vc)
        }
        view.addSubview(sccccc)
        NotificationCenter.default.addObserver(self, selector: #selector(scrollStatusMethod), name: Notification.Name("leaveTop"), object: nil)
        
        
        
    }

}
extension ZhalieVC:UIScrollViewDelegate {
    
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            if scrollView == sccccc {
                let vel: CGPoint = scrollView.panGestureRecognizer.velocity(in: scrollView)
                if vel.y < -5 {
                    //向上
                    print("向上")
                    if scrollView.contentOffset.y >= headerHeight {
                        for vc in vcs{
                            vc.scrollEnabled = true
                        }
                    }else{
                        for vc in vcs {
                            vc.scrollEnabled = false
                        }
                    }
                }else if vel.y > 5 {
                    print("向下")
                }else if vel.y == 0 {
                    for vc in vcs {
                        vc.scrollEnabled = true
                    }
                }
                if scrollView.contentOffset.y <= 0 {
                    scrollView.contentOffset = CGPoint(x: 0, y: 0)
                }
                let topHeigth:CGFloat = headerHeight
                if scrollView.contentOffset.y >= topHeigth {
                    scrollView.contentOffset = CGPoint(x: 0, y: topHeigth)
                    if self.scrollEnabled {
                        self.scrollEnabled = false
                        for vc in vcs {
                            vc.scrollEnabled = true
                        }
                    }
                }else{
                    if !self.scrollEnabled {
                        scrollView.contentOffset = CGPoint(x: 0, y: topHeigth)
                    }
                }
            }
        }

    @objc func scrollStatusMethod(){
        self.scrollEnabled = true;
        for vc in vcs {
            vc.scrollEnabled = true
            if sccccc.contentOffset.y != 0 {
                vc.kTableView?.contentOffset = .zero;
            }else{
                vc.kTableView?.bounces = true
                vc.scrollEnabled = true
            }
            
        }
    }
    
}
