//
//  UserCell.swift
//  TB
//
//  Created by dzc on 2020/8/18.
//  Copyright © 2020 PHJTYTJ-0003. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

    var userInfo: UserInfo? {
        didSet{
            headerImageV.image = UIImage(named: userInfo?.avt! ?? "")
            titleLable.text = userInfo?.name
        }
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var headerImageV: UIImageView = {
        let imgeV = UIImageView.init()
        imgeV.contentMode = .scaleAspectFill
        imgeV.clipsToBounds = true
        return imgeV
    }()
    lazy var titleLable: UILabel = {
        let titleLabel = UILabel.init()
        titleLabel.textAlignment = .left
        //        titleLabel.textColor =
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        return titleLabel
    }()
    lazy var lineLabel: UILabel = {
        let lineLabell = UILabel.init()
        lineLabell.backgroundColor = .gray
        return lineLabell
    }()
}
extension UserCell {
    private func addViews(){
        contentView.addSubview(headerImageV)
        contentView.addSubview(titleLable)
        contentView.addSubview(lineLabel)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        headerImageV.frame = CGRect(x: 15, y: 10, width: 45, height: 45)
        titleLable.frame = CGRect(x: 15+45+10, y: 0, width: 100, height: 65)
        lineLabel.frame = CGRect(x: 15, y: 64.5, width: UIScreen.main.bounds.size.width - 30, height: 0.5)
    }
}
