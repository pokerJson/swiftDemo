//
//  SUOYIN.swift
//  TB
//
//  Created by dzc on 2020/8/19.
//  Copyright © 2020 PHJTYTJ-0003. All rights reserved.
//

import UIKit

class SUOYIN: UIView {

    var isShowTipView: Bool?
    var tableView: UITableView?
    
    var tipViewBackgroundImage: UIImage? {
        didSet{
            titleTipImageView?.image = tipViewBackgroundImage
        }
    }
    var tipViewBackgroundColor: UIColor? {
        didSet{
            titleTipImageView?.backgroundColor = tipViewBackgroundColor
        }
    }
    var tipViewTitleColor: UIColor? {
        didSet{
            titleTipLabel?.textColor = tipViewTitleColor
        }
    }
    var tipViewTitleFont: UIFont? {
        didSet{
            titleTipLabel?.font = tipViewTitleFont
        }
    }
    
    private var titleLabelW: CGFloat = 12
    private var titleLabelH: CGFloat = 12
    private var titleLabelFont: CGFloat = 9
    private var titleLabelTopMargin: CGFloat = 6
    private var titleLabelRightMargin: CGFloat = 12
    private var titleLabelVerticalMargin: CGFloat = 2

    private var titlesArray = Array<String>()
    private var titleLabelsArray = Array<Any>()
    private var titleLabelCacheArray = Array<Any>()
    private var isMoveOutView: Bool?
    private var titleTipImageView: UIImageView?
    private var titleTipLabel: UILabel?
    
    
    private func initUI() -> () {
        backgroundColor = .clear
        isShowTipView = false
        titleTipImageView = UIImageView.init()
        titleTipLabel = UILabel.init()
        titleTipImageView?.frame = CGRect(x: -(10/2.0+100/2.0), y: 0, width: 110/2.0, height: 100/2.0)
        let Screen_Width = UIScreen.main.bounds.size.width
        let Screen_Height = UIScreen.main.bounds.size.height
        let centerX = -Screen_Width/2.0+self.frame.size.width
        let centerY = Screen_Height/2.0-64
        titleTipImageView!.center = CGPoint(x: centerX, y: centerY)
        titleTipImageView?.backgroundColor = .white
        titleTipImageView?.layer.masksToBounds = true
        titleTipImageView?.layer.cornerRadius = 4
        titleTipLabel?.frame = titleTipImageView?.bounds as! CGRect
        titleTipLabel?.font = UIFont.systemFont(ofSize: 17)
        titleTipLabel?.textAlignment = .center
        titleTipLabel?.textColor = .white
        titleTipLabel?.backgroundColor = .clear
        titleTipImageView?.addSubview(titleTipLabel!)
        titleTipImageView?.isHidden = true
        addSubview(titleTipImageView!)
        
    }
    func refreshUI() -> () {
        if titlesArray.count <= 0 {
            return
        }
        for view in subviews {
            if view.isKind(of: UILabel.self) && view != titleTipLabel {
                view.removeFromSuperview()
            }
        }
        var selfFrame = self.frame
        selfFrame.size.width = 20.0
        selfFrame.size.height = (CGFloat)(titleLabelH+2.0)*CGFloat(titlesArray.count) + 14/2.0
        self.frame = selfFrame
        
        if tableView != nil {
            if self.frame.size.height >= tableView!.frame.size.height-10 {
                selfFrame = self.frame
                selfFrame.size.height = self.tableView!.frame.size.height-10;
                self.frame = selfFrame
                let verticalMargin = (self.frame.size.height - self.titleLabelTopMargin)/CGFloat(self.titlesArray.count) - self.titleLabelH;
                if verticalMargin < 2.0 {
                    titleLabelVerticalMargin = verticalMargin
                }else{
                    titleLabelVerticalMargin = 2.0
                }
            }else{
                let verticalMargin = (self.frame.size.height - self.titleLabelTopMargin)/CGFloat(self.titlesArray.count) - self.titleLabelH;
                if verticalMargin > 7.0 {
                    titleLabelVerticalMargin = 7.0
                }else{
                    titleLabelVerticalMargin = 2.0
                }
                selfFrame = self.frame
                selfFrame.size.height = (titleLabelH+titleLabelVerticalMargin)*CGFloat(titlesArray.count) + 14/2.0;
                self.frame = selfFrame
            }
            var selfCenterPoint = self.center
            selfCenterPoint.y = CGFloat((tableView?.center.y)!)
            center = selfCenterPoint
        }

        let x: CGFloat = 0
        var y: CGFloat = 0
        let w: CGFloat = titleLabelW
        let h: CGFloat = titleLabelH

        for i in 0..<titlesArray.count {
            let title: String = titlesArray[i]
            var label: UILabel? = getCacheLabel()
            if label == nil {
                label = UILabel.init()
            }
            y = (w+titleLabelVerticalMargin)*CGFloat(i) + titleLabelTopMargin;
            label!.frame = CGRect(x: x, y: y, width: w, height: h)
            label?.textColor = .black
            label?.font = UIFont.systemFont(ofSize: titleLabelFont)
            label?.textAlignment = .center
            label?.backgroundColor = .clear
            
            var center = label?.center
            center?.x = frame.size.width/2.0
            label?.center = center!
            label?.text = title
            label?.isUserInteractionEnabled = true
            label?.tag = i
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(labelTap(gets:)))
            label!.addGestureRecognizer(tap)
            addSubview(label!)
            titleLabelsArray.append(label!)
        }
        var tCenter = titleTipImageView?.center
        tCenter?.y = self.frame.size.height/2.0
        titleTipImageView?.center = tCenter!

    }
    @objc func labelTap(gets: UITapGestureRecognizer) {
        titleTipLabel?.text = titlesArray[gets.view!.tag]
        titleTipImageView?.isHidden = false
        titleTipLabel?.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1) {
            self.titleTipImageView?.isHidden = true
            self.titleTipLabel?.isHidden = true
        }
        tableViewSectionIndexTitle(tit: titlesArray[gets.view!.tag], atIndex: gets.view!.tag)

    }
    func getCacheLabel() -> UILabel? {
        var label: UILabel?
        if titleLabelCacheArray.count > 0 {
            label = titleLabelCacheArray.last as! UILabel
            titleLabelCacheArray.removeLast()
        }
        return label
        
    }
    func setIndexTitlesArray(titlesArray: Array<String>) -> () {
        if self.titlesArray == nil {
            self.titlesArray = Array()
        }
        self.titlesArray .removeAll()
        self.titlesArray.append(contentsOf: titlesArray)
        self.titleLabelCacheArray.append(contentsOf: self.titleLabelsArray)
        self.titleLabelsArray.removeAll()
        refreshUI()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        isMoveOutView = false
        for touch: AnyObject in touches {
            let point = (touch as AnyObject).location(in: self)
            indexTouchedInView(location:point.y)
        }
        
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        backgroundColor = .clear
        for touch: AnyObject in touches {
            let location = (touch as AnyObject).location(in: self)
            if isMoveOutView == false {
                indexTouchedInView(location:location.y)
            }else{
                
            }
            titleTipImageView?.isHidden = true
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        for touch: AnyObject in touches {
            let location = (touch as AnyObject).location(in: self)
            
            if self.point(inside: location, with: nil) == false {
                isMoveOutView = true
            }else{
                isMoveOutView = false
                let hitView: UIView? = self.hitTest(location, with: nil)
                if hitView == self {
                    
                }else{
                    
                }
                indexTouchedInView(location: location.y)
            }
        }
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        backgroundColor = .clear
        titleTipImageView?.isHidden = true
    }
    func indexTouchedInView(location:CGFloat) -> () {
        let index = getCurrentLabelWithLoactionY(loca:location)
        if index < 0 {
            return
        }
        let title: String = titlesArray[index] as! String
        titleTipLabel?.text = title
        if isShowTipView == true {
            titleTipImageView?.isHidden = false
            titleTipLabel?.isHidden = false
        }else{
            titleTipImageView?.isHidden = true
            titleTipLabel?.isHidden = true
        }
        tableViewSectionIndexTitle(tit: title, atIndex: index)
        
    }
    func tableViewSectionIndexTitle(tit: String,atIndex: Int) -> () {
        let indexPath: IndexPath = IndexPath.init(row: 0, section: atIndex)
        if titlesArray.count <= indexPath.row {
            return
        }
        if indexPath.section == 0 {
            var offset = tableView?.contentOffset
            offset?.y = -(tableView?.contentInset.top)!
            tableView?.contentOffset = offset!
        }else{
            tableView?.scrollToRow(at: indexPath, at: .top, animated: false)
        }
    }
    func getCurrentLabelWithLoactionY(loca:CGFloat) -> Int {
        var index: Int = Int((loca - titleLabelTopMargin)/(titleLabelW+titleLabelVerticalMargin));
        if index >= titlesArray.count {
            index = titlesArray.count - 1
        }
        if index < 0 {
            index = 0
        }
        if titlesArray.count == 0 {
            return -1
        }
        return index
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    

}
