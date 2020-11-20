//
//  LeftViewController.swift
//  TB
//
//  Created by dzc on 2020/8/17.
//  Copyright © 2020 PHJTYTJ-0003. All rights reserved.
//

import UIKit
import MJRefresh

class LeftViewController: BaseViewController {

    //MARK:属性
    lazy var theCollation: UILocalizedIndexedCollation = {
        let coll = UILocalizedIndexedCollation.current()
        return coll
    }()
    lazy var letterNormalArr: Array<String> = {
        let letter = ["A","B","C","D","E","F","G","H","I","G","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","#"]
        return letter
    }()
    //自定义的索引 《--------------------》
    lazy var tableViewIndexView: SUOYIN = {
        let syView = SUOYIN.init(frame: CGRect(x: 0, y: 0, width: 20, height: self.kScreenHeight-88-44-83))
        syView.tableView = self.tabView
        var frame = syView.frame
        frame.origin.x = self.tabView.frame.size.width-syView.frame.size.width
        frame.origin.y = self.tabView.frame.origin.y + self.tabView.contentInset.top
        syView.frame = frame
        syView.isShowTipView = true
        syView.tipViewTitleFont = UIFont.systemFont(ofSize: 24)
        syView.tipViewBackgroundColor = .red
        return syView
    }()
    ///右侧索引字母数组
    var letterArr: [String] = [String]()
    ///二维数组 保存内个section对应的数组
    var dataArr = [[Any]]()

    lazy var tabView: UITableView = {
        let tab = UITableView.init(frame: CGRect(x: 0, y: 0, width: self.kScreenWidth, height: kScreenHeight-kNAVBARH-44), style: .plain)
        tab.delegate = self
        tab.dataSource = self
        tab.tableFooterView = UIView.init()
        tab.register(UserCell.self, forCellReuseIdentifier: "II")
        tab.sectionIndexBackgroundColor = .clear
        tab.sectionIndexColor = .gray
        tab.mj_header = EPRefresh.instance.ep_refreshHeaderHandler(tabView: tab, callBack: {
            Dlog(item: "asdfasdfsadfasdfasd")
            sleep(2)
            tab.mj_header?.endRefreshing()
        })
        tab.mj_footer = EPRefresh.instance.ep_refreshFooterHandler(tabView: tab, callBack: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                tab.mj_footer?.endRefreshing()
            }
        })
//        self.kTableView = tab
        return tab
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(tabView)
        //自定义的索引 《--------------------》
//        tabView.superview?.addSubview(tableViewIndexView)
        let allArr: Array<String> = ["爱","i","jin","姜茶","警察","o","rto","1","zhang","1dd","马大哈","wangpangzi","你大爷","loidehua","刘德华","重","我擦","kaikai"]
        var userArr: Array<UserInfo> = Array.init()
        
        for item in allArr {
            let user = UserInfo.init()
            user.avt = "11.png"
            user.name = item
            
            userArr.append(user)
        }
        for item in userArr {
            let section = theCollation.section(for: item, collationStringSelector: #selector(getter: UserInfo.name))
            item.sectionNumber = section
        }
        
        
        //多少个section
        let sectionCount = theCollation.sectionTitles.count
        //二维数组
        var sectionArr = [[Any]]()
        for _ in 0..<sectionCount {
            let tmpArr = Array<Any>.init()
            sectionArr.append(tmpArr)
        }
        //把userinfo加入数组
        for item in userArr {
            sectionArr[item.sectionNumber!].append(item)
        }
        //排序
        for item in sectionArr {
            
            if item.isEmpty == false {
                let sortArr = theCollation.sortedArray(from: item, collationStringSelector: #selector(getter: UserInfo.name))
                dataArr.append(sortArr)
            }
        }
        //右侧索引标题字母
        for item in dataArr {
            if item.isEmpty == false {
                let user: UserInfo = item[0] as! UserInfo
                letterArr.append(letterNormalArr[user.sectionNumber!])
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("leftvc--viewwillappear")
    }
   

}
extension LeftViewController: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return letterArr.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr[section].count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "II") as! UserCell
        cell.userInfo = dataArr[indexPath.section][indexPath.row] as? UserInfo
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    
    //系统索引
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return letterArr
        return nil
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return letterArr[section]
    }
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {

        //1 tableView总高度
        var totalHeight: CGFloat = 0
        for item in 0..<letterArr.count {
            totalHeight += (CGFloat)(dataArr[item].count*65 + 25)
        }
        //2 要滚动的高度
        var scrollY: CGFloat = 0
        for item in 0..<index {
            scrollY += CGFloat((dataArr[item].count*65 + 25))
        }
        //3 当剩下的高度大于tableview视图高度时候用setContentOffset
        if (totalHeight - scrollY) >= (kScreenHeight-88-44-83) {
            tableView.setContentOffset(CGPoint(x: 0, y: scrollY), animated: true)
            return -1
        }else{
            //剩下的高度小于tableview视图高度的时候用系统定位
            return index
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("leftvd-------\(scrollView.contentOffset.y)")
        if (scrollView == tabView) {
            if (!self.scrollEnabled) {
                scrollView.contentOffset = .zero;
            }
            if (scrollView.contentOffset.y <= 0) {
                self.scrollEnabled = false;
                scrollView.contentOffset = .zero;
                NotificationCenter.default.post(name: Notification.Name("leaveTop"), object: nil)
            }
        }
    }
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print("leftvd------===\(scrollView.contentOffset.y)")
//        if scrollView.contentOffset.y > 0 {
//            if self.scrollEnabled {
//                NotificationCenter.default.post(name: Notification.Name("mainScrollViewCanScroll"), object: nil)
//            }
//            if (scrollView == tabView) {
//                if (!self.scrollEnabled) {
//                    scrollView.contentOffset = .zero;
//                }
//                if (scrollView.contentOffset.y <= 0) {
//                    self.scrollEnabled = true;
//                    scrollView.contentOffset = .zero;
//                    NotificationCenter.default.post(name: Notification.Name("leaveTop"), object: nil)
//                }
//            }
//        }else{
//
//            self.scrollEnabled = false;
//            if !self.mainCanScrol {
//                if self.initSelf {
//                    scrollView.bounces = false;
//                }else{
////                    scrollView.bounces = true;
//
//                }
//
//            }else{
//                scrollView.bounces = false
//            }
////            NotificationCenter.default.post(name: Notification.Name("mainScrollViewCanScroll"), object: nil)
//
////            scrollView.contentOffset = .zero;
////            NotificationCenter.default.post(name: Notification.Name("leaveTop"), object: nil)
//
//
//        }
//
//    }
}

class UserInfo {
    var avt: String?
    @objc var name: String?
    var detail: String?
    
    var sectionNumber: Int? //section标识
    
}
