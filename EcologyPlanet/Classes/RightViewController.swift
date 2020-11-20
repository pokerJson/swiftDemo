//
//  RightViewController.swift
//  TB
//
//  Created by dzc on 2020/8/17.
//  Copyright © 2020 PHJTYTJ-0003. All rights reserved.
//

import UIKit

class RightViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "III")
        cell?.textLabel?.text = "发送到发送"
        return cell ?? UITableViewCell()
    }
    
    lazy var tabView: UITableView = {
        let tab = UITableView.init(frame: CGRect(x: 0, y: 0, width: self.kScreenWidth, height: kScreenHeight-self.kNAVBARH-44), style: .plain)
        tab.delegate = self
        tab.dataSource = self
        tab.tableFooterView = UIView.init()
        tab.register(UITableViewCell.self, forCellReuseIdentifier: "III")
        tab.sectionIndexBackgroundColor = .clear
        tab.sectionIndexColor = .gray
    
//        self.kTableView = tab
        return tab
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
        view.addSubview(tabView)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("rightvc--viewwillappear")
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
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
    
}
