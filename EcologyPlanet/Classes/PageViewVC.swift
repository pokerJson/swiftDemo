//
//  PageViewVC.swift
//  EcologyPlanet
//
//  Created by dzc on 2020/11/18.
//

import UIKit

class PageViewVC: BaseViewController {
    
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
    var vcs = [RightViewController(),LeftViewController()]
    lazy var pageView: EPPageView = {
        let result = EPPageView(frame: CGRect(x: 0, y: headerHeight, width: SCREEN_WIDTH, height: SCREENT_HEIGHT-kTABBARH), titles: ["推是荐","视发到频"], childControllers: vcs, parentController: self, style: self.style)
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
//        self.scrollEnabled = false //进来不让滑动主scrollview
        
        //常规用法
        //        let style = EPPageStyle()
        //        style.labelLayout = .center
        //        style.isFixedLineWidth = false//是否固定line的宽度 这个等级最高，设置为true其他的设置无效bottomAlginLabel
        //
        //        let pageView = EPPageView(frame: CGRect(x: 0, y: 88, width: SCREEN_WIDTH, height: SCREENT_HEIGHT-88),
        //                                titles: ["推是荐","关方法注","视发到频","视发到频"],
        //                                childControllers: [LeftViewController(),LeftViewController(),RightViewController(),LeftViewController()],
        //                                parentController: self,style: style)
        //        view.addSubview(pageView)
        //        view.addSubview(tabV)
        view.addSubview(sccccc)
        NotificationCenter.default.addObserver(self, selector: #selector(scrollStatusMethod), name: Notification.Name("leaveTop"), object: nil)
        
        
        
        ////测试
        NotificationCenter.default.addObserver(self, selector: #selector(mainScrollViewCanScroll), name: Notification.Name("mainScrollViewCanScroll"), object: nil)

        
    }

}
extension PageViewVC:UIScrollViewDelegate {
    
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            print(scrollView.contentOffset.y)
    
            if scrollView == sccccc {
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
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print("主scrolview==\(scrollView.contentOffset.y)")
//
//        if scrollView == sccccc {
//            let topHeigth:CGFloat = headerHeight
//            if scrollView.contentOffset.y >= topHeigth {
//                scrollView.contentOffset = CGPoint(x: 0, y: topHeigth)
//                if self.scrollEnabled {
//                    self.scrollEnabled = false
//                    for vc in vcs {
//                        vc.scrollEnabled = true
//                    }
//                }
//            }else{
//                for vc in vcs {
//                    vc.kTableView?.bounces = false
//                }
//                if !self.scrollEnabled {
//                    scrollView.contentOffset = CGPoint(x: 0, y: 0)
//                    if scrollView.contentOffset.y <= 0 {
//                        scrollView.bounces = false
//                        for vc in vcs {
//                            vc.scrollEnabled = true
//                            vc.kTableView?.bounces = true
//
//                        }
//
//                    }
//
//                    if vcs.first?.scrollEnabled == true{
//                        if scrollView.contentOffset.y != 0 {
//                            scrollView.contentOffset = CGPoint(x: 0, y: 0)
//                        }
//                    }
//                }else{
//                    if scrollView.contentOffset.y <= topHeigth {
//                        self.mainCanScrol = true
////                        scrollView.bounces = false
//                        for vc in vcs {
//                            vc.scrollEnabled = false
//                        }
//                    }
//                }
//            }
//        }
//    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        print("主scrolview22222==\(scrollView.contentOffset.y)")
    }
    @objc func scrollStatusMethod(){
        self.scrollEnabled = true;
        for vc in vcs {
            vc.scrollEnabled = false
            vc.kTableView?.contentOffset = .zero;
            
        }
    }
    @objc func mainScrollViewCanScroll(){
        self.scrollEnabled = true;
        for vc in vcs {
            vc.scrollEnabled = false
            vc.kTableView?.contentOffset = .zero;
            
        }
    }
    
}

