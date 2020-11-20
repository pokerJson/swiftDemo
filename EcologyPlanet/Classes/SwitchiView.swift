//
//  SwitchiView.swift
//  TB
//
//  Created by dzc on 2020/8/17.
//  Copyright © 2020 PHJTYTJ-0003. All rights reserved.
//

import UIKit

typealias Handle<T,A> = (T,A) -> ()

class SwitchiView: UIView {

    let svWidth = UIScreen.main.bounds.width
    let svHeight = UIScreen.main.bounds.height
    
    //block
    var loadViewHandle: Handle<UIScrollView,Int>?
    var currentIndexHandle: Handle<UIScrollView,Int>?

    var leftLabel: UILabel!
    var rightLabel: UILabel!
    var sliderV: UIView!
    var bottomLine: UIView!
    var tabBarHeight: CGFloat = 44
    var sliderWidth: CGFloat = 24

    var normalFont: UIFont = UIFont.systemFont(ofSize: 16)
    var selectedFont: UIFont = UIFont.systemFont(ofSize: 16)
    var normalColor: UIColor = .gray
    var selectedColor: UIColor = .red
    
    var controllerView: UIScrollView!
    
    var loadIndex: Int = 0
    var currentIndex: Int = 0
    
    
    
    
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    

}
extension SwitchiView: UIScrollViewDelegate {
    private func addSubViews() {
        
        leftLabel = UILabel.init(frame: CGRect(x: 0, y: 0, width: svWidth/2, height: tabBarHeight))
        leftLabel.isUserInteractionEnabled = true
        leftLabel.textAlignment = .center
        leftLabel.font = normalFont
        leftLabel.textColor = normalColor
        leftLabel.tag = 100
        let tap1 = UITapGestureRecognizer.init(target: self, action: #selector(tabBarClick(sender:)))
        leftLabel.addGestureRecognizer(tap1)
        addSubview(leftLabel)
        
        rightLabel = UILabel.init(frame: CGRect(x: svWidth/2, y: 0, width: svWidth/2, height: tabBarHeight))
        rightLabel.isUserInteractionEnabled = true
        rightLabel.textAlignment = .center
        rightLabel.font = normalFont
        rightLabel.textColor = normalColor
        rightLabel.tag = 200
        let tap2 = UITapGestureRecognizer.init(target: self, action: #selector(tabBarClick(sender:)))
        rightLabel.addGestureRecognizer(tap2)
        addSubview(rightLabel)
        
        sliderV = UIView.init(frame: CGRect(x: (svWidth/4-sliderWidth/2), y: tabBarHeight-1.4, width: sliderWidth, height: 1))
        sliderV.backgroundColor = .red
        addSubview(sliderV)
        
        bottomLine = UIView.init(frame: CGRect(x: 0, y: tabBarHeight-0.4, width: svWidth, height: 0.4))
        bottomLine.backgroundColor = .gray
        addSubview(bottomLine)
        
        controllerView = UIScrollView.init(frame: CGRect(x: 0, y: tabBarHeight, width: svWidth, height: self.frame.size.height-tabBarHeight))
        controllerView.backgroundColor = .white
        controllerView.isScrollEnabled = true
        controllerView.showsHorizontalScrollIndicator = false
        controllerView.isPagingEnabled = true
        controllerView.delegate = self
        addSubview(controllerView)
        
        leftLabel.textColor = selectedColor
        leftLabel.font = selectedFont
        
        
    }
    func titleArr(_ titles: Array<String> ,loadViewBlock: @escaping Handle<UIScrollView,Int> ,currnetIndexBlock: @escaping Handle<UIScrollView,Int>) {
        
        loadViewHandle = loadViewBlock
        currentIndexHandle = currnetIndexBlock
        
        guard titles.count > 0 else {
            print("数组是空")
            return
        }
        leftLabel.text = titles.first
        rightLabel.text = titles.last
        controllerView.contentSize = CGSize(width: CGFloat(titles.count) * svWidth, height: self.frame.size.height-tabBarHeight)
        self.callBlock()
        
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollX = scrollView.contentOffset.x
        let currentPage = (Int)((scrollX + svWidth/2.0)/svWidth)
        
        if scrollX < svWidth && scrollX > 0 {
            sliderV.frame = CGRect(x: svWidth/4-sliderWidth/2 + scrollX/2, y: tabBarHeight-1.4, width: sliderWidth, height: 1)
        }
        if scrollX == svWidth {
            rightLabel.textColor = selectedColor
            rightLabel.font = selectedFont
            leftLabel.textColor = normalColor
            leftLabel.font = normalFont
        }else if scrollX == 0{
            leftLabel.textColor = selectedColor
            leftLabel.font = selectedFont
            rightLabel.textColor = normalColor
            rightLabel.font = normalFont
        }
        guard loadIndex != currentPage else {
            return
        }
        loadIndex = currentPage
        currentIndex = currentPage
        self.callBlock()
      
    }
    @objc private func tabBarClick(sender: UITapGestureRecognizer){
        if sender.view?.tag == 100 {
            leftLabel.textColor = selectedColor
            leftLabel.font = selectedFont
            rightLabel.textColor = normalColor
            rightLabel.font = normalFont
            loadIndex = 0
            currentIndex = 0
            UIView.animate(withDuration: 0.25, animations: {
                self.sliderV.frame = CGRect(x: (self.svWidth/4-self.sliderWidth/2), y: self.tabBarHeight-1.4, width: self.sliderWidth, height: 1)
            }) { (bo) in
                self.callBlock()
            }
        }else{
            rightLabel.textColor = selectedColor
            rightLabel.font = selectedFont
            leftLabel.textColor = normalColor
            leftLabel.font = normalFont
            loadIndex = 1
            currentIndex = 1
            UIView.animate(withDuration: 0.25, animations: {
                self.sliderV.frame = CGRect(x: (self.svWidth/4-self.sliderWidth/2)+self.svWidth/2, y: self.tabBarHeight-1.4, width: self.sliderWidth, height: 1)
            }) { (bo) in
                self.callBlock()
            }
        }
        controllerView.setContentOffset(CGPoint(x: Int(svWidth) * loadIndex, y: 0), animated: true)
    }
    //MARK:闭包回调
    private func callBlock() {
        if loadViewHandle != nil {
            loadViewHandle!(controllerView,loadIndex)
        }
        if currentIndexHandle != nil {
            currentIndexHandle!(controllerView,currentIndex)
        }
    }
    
}
