//
//  MainViewController.swift
//  TB
//
//  Created by dzc on 2020/8/10.
//  Copyright © 2020 PHJTYTJ-0003. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController, UITabBarControllerDelegate {
    
    
    lazy var mainTabBar: MainTabBar = {
       let tabBar = MainTabBar.init(frame: self.tabBar.bounds)
        tabBar.delegate = self
        return tabBar
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tabBar.addSubview(mainTabBar)
        addChildViewControllers()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        for child in tabBar.subviews {
            if child.isKind(of: UIControl.self) {
                child.removeFromSuperview()
            }
        }
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        for child in tabBar.subviews {
            if child.isKind(of: UIControl.self) {
                child.removeFromSuperview()
            }
        }
    }

}
extension MainViewController: MainTabBarDelegate{
    private func addChildViewControllers(){
        tabBar.isTranslucent = false
        delegate = self
        
        addchildVC(FirstVC.init(), "首页", "dg_tab_homePage_normal_icon", "dg_tab_homePage_selected_icon")
        addchildVC(SecondVC.init(), "传导践行", "dg_tab_school_normal_icon", "dg_tab_school_selected_icon")
        addchildVC(ThirdVC.init(), "学堂", "dg_tab_study_normal_icon", "dg_tab_study_selected_icon")
        addchildVC(FourthVC.init(), "解惑", "dg_tab_Q&A_normal_icon", "dg_tab_Q&A_selected_icon")
        addchildVC(FiveVC.init(), "自己", "dg_tab_mine_normal_icon", "dg_tab_mine_selected_icon")
    }
    private func addchildVC(_ childVC: UIViewController, _ title: String, _ normalImage: String, _ selectedImage: String){
        
        ///1
        childVC.title = title
        childVC.navigationItem.title = title
        ///2
        childVC.tabBarItem.image = UIImage(named: normalImage)?.withRenderingMode(.alwaysOriginal)
        childVC.tabBarItem.selectedImage = UIImage(named: selectedImage)?.withRenderingMode(.alwaysOriginal)
        ///3
        var textAttrs: [NSAttributedString.Key:Any] = Dictionary()
        textAttrs[NSAttributedString.Key.foregroundColor] = UIColor.gray
        var selectedTextAttrs: [NSAttributedString.Key:Any] = Dictionary()
        selectedTextAttrs[NSAttributedString.Key.foregroundColor] = UIColor.orange
        UITabBarItem.appearance().setTitleTextAttributes(textAttrs, for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes(selectedTextAttrs, for: .selected)
    
        ///4
        let nav = BaseNavBarViewController.init(rootViewController: childVC)
        nav.addChild(childVC)
        ///5
        mainTabBar.addTabBarButtonWithTabBarItem(childVC.tabBarItem)
        ///6
        self.addChild(nav)
        
    }
    //mainviewcontroller的方法
    public func selectedItemIndex(_ index: Int){
        mainTabBar.selecedItemIndex(index)
    }
    public func itemIndex(index: Int ,badgeCount: String){
        mainTabBar.itemIndex(index, badgeCount: badgeCount)
    }
    ///Maintabbar 代理
    func tabBar(_ tabBar: MainTabBar, didSelectedButtonFrom: Int, to: Int) {
        selectedIndex = to
    }
    
    func tabBarClickWriteButton(_ tabBar: MainTabBar) {
        
    }
    
    func tabBarShouldSelectedButtonFrom(_ fromBtnTag: Int ,to: Int) -> Bool {
        return true
    }
    //系统代理方法
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController == tabBarController.viewControllers?.last {
            return true
        }
        return true
    }
}
//MARK:协议
protocol MainTabBarDelegate {
    func tabBar(_ tabBar: MainTabBar ,didSelectedButtonFrom: Int ,to: Int)
    func tabBarClickWriteButton(_ tabBar: MainTabBar)
    func tabBarShouldSelectedButtonFrom(_ fromBtnTag: Int ,to: Int) -> Bool
}
//MARK:MainTabBar
class MainTabBar: UIView {
    //代理
    var delegate: MainTabBarDelegate?
    
    private var selectedButton: MainTabBarButton!
    
    private lazy var tabbarBtnArray: Array<Any> = {
        var arr = Array<Any>()
        return arr
    }()
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let btnY: CGFloat = 0
        let btnW = (frame.size.width) / (CGFloat)(subviews.count)
        let btnH = frame.size.height
        
        for index in 0..<tabbarBtnArray.count {
            let btnX = btnW * CGFloat(index)
            let tabBarBtn: MainTabBarButton = tabbarBtnArray[index] as! MainTabBarButton
            tabBarBtn.frame = CGRect(x: btnX, y: btnY, width: btnW, height: btnH)
            tabBarBtn.tag = index
        }
        
        
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        selectedButton = MainTabBarButton.init()
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
extension MainTabBar {
    func addTabBarButtonWithTabBarItem(_ tabBarItem: UITabBarItem) {
        let tabBarBtn: MainTabBarButton = MainTabBarButton.init()
        tabBarBtn.tabBarItem = tabBarItem
        tabBarBtn.addTarget(self, action: #selector(ClickTabBarButton(tabBarBtn:)), for: .touchUpInside)
        addSubview(tabBarBtn)
        tabbarBtnArray.append(tabBarBtn)
        
        ///Moren
        if tabbarBtnArray.count == 1 {
            ClickTabBarButton(tabBarBtn: tabBarBtn)
        }
    }
    func selecedItemIndex(_ index: Int) {
        let tabBarBtn: MainTabBarButton = tabbarBtnArray[index] as! MainTabBarButton
        ClickTabBarButton(tabBarBtn: tabBarBtn)
    }
    func itemIndex(_ index: Int ,badgeCount: String) {
        let tabBarBtn: MainTabBarButton = tabbarBtnArray[index] as! MainTabBarButton
        tabBarBtn.badgeCount = badgeCount
    }
    @objc private func ClickTabBarButton(tabBarBtn:MainTabBarButton){
        print("点击了tabBar=\(tabBarBtn.tag)")
        let isSeleted: Bool = (delegate?.tabBarShouldSelectedButtonFrom(selectedButton.tag, to: tabBarBtn.tag))!
        if !isSeleted {
            return
        }
        
        
        delegate?.tabBar(self, didSelectedButtonFrom: selectedButton.tag, to: tabBarBtn.tag)
        selectedButton?.isSelected = false
        tabBarBtn.isSelected = true
        selectedButton = tabBarBtn
    }
}

//MARK:自定义button
class MainTabBarButton: UIButton {
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView?.contentMode = .bottom
        titleLabel?.textAlignment = .center
        titleLabel?.font = UIFont.systemFont(ofSize: 10.0)
        setTitleColor(.gray, for: .normal)
        setTitleColor(.orange, for: .selected)
        
        addSubview(badgeLabel)
        
        let badgeX = (UIScreen.main.bounds.size.width/5)/2+12
        let badgeY: CGFloat = 3
        let badgeWH: CGFloat = 12
        badgeLabel.frame = CGRect(x: badgeX, y: badgeY, width: badgeWH, height: badgeWH)
        
    }
    
    //重写按钮点击高亮显示，这里不出现高亮
    override var isHighlighted: Bool{
        set {}
        get {
            return false
        }
    }
    //重写按钮图片位置
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        let imageW: CGFloat = contentRect.size.width
        let imageH: CGFloat = contentRect.size.height*0.6
        return CGRect(x: 0, y: 0, width: imageW, height: imageH)
        
    }
    //重写按钮文字
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        let titleY: CGFloat = contentRect.size.height*0.6
        let titleW: CGFloat = contentRect.size.width
        let titleH: CGFloat = contentRect.size.height - titleY
        return CGRect(x: 0, y: titleY, width: titleW, height: titleH)
    
    }
    //属性
    fileprivate var tabBarItem: UITabBarItem?{
        didSet{
            setTitle(tabBarItem?.title, for: .normal)
            setImage(tabBarItem?.image, for: .normal)
            setImage(tabBarItem?.selectedImage, for: .selected)
        }
    }
    fileprivate var badgeCount: String?{
        didSet{
            if Int(badgeCount!)! > 9 {
                badgeCount = "9+"
            }
            if badgeCount == "" || Int(badgeCount!) == 0 {
                badgeLabel.isHidden = true
            }else{
                badgeLabel.isHidden = false
                badgeLabel.text = badgeCount
            }
            if badgeCount == "9+" {
                let badgeX = (UIScreen.main.bounds.size.width/5)/2+12
                let badgeY: CGFloat = 3
                let badgeW: CGFloat = 12 + 6
                let badgeH: CGFloat = 12
                badgeLabel.frame = CGRect(x: badgeX, y: badgeY, width: badgeW, height: badgeH)
            }
        }
    }
    
    fileprivate lazy var badgeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.backgroundColor = .red
        label.font = UIFont.systemFont(ofSize: 8)
        label.layer.cornerRadius = 6
        label.layer.masksToBounds = true
        label.isHidden = true
        label.textAlignment = .center
        return label
    }()
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
