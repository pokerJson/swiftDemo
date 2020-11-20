//
//  EPUserInfo.swift
//  EcologyPlanet
//
//  Created by dzc on 2020/11/17.
//

import Foundation
import UIKit

class EPUserInfo: NSObject,NSCoding,NSSecureCoding {
    static var instance: EPUserInfo = {
        let instance = EPUserInfo()
        return instance
    } ()
    
    private override init() {}
    
    var token: String?
    var userName: String?
    var userID: String?
    var age: Int?
    var sex: Int?
    
    
    //必须项
    static var supportsSecureCoding: Bool{
        return true
    }
    //编码
    func encode(with coder: NSCoder) {
        coder.encode(token, forKey: "token")
        coder.encode(userName, forKey: "userName")
        coder.encode(userID, forKey: "userID")
        coder.encode(age, forKey: "age")
        coder.encode(sex, forKey: "sex")
    }
    //解码
    required init?(coder: NSCoder) {
        super.init()
        token = coder.decodeObject(forKey: "token") as? String
        userName = coder.decodeObject(forKey: "userName") as? String
        userID = coder.decodeObject(forKey: "userID") as? String
        age = coder.decodeObject(forKey: "age") as? Int
        sex = coder.decodeObject(forKey: "sex") as? Int
    }
    
}
extension EPUserInfo {
    public static func archivedData(info: EPUserInfo){
        let file = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
        // 拼接路径 自动带斜杠的
        let filePath = (file as NSString).appendingPathComponent("UserAccount.archiver")
        print("用户信息路径:\(filePath)")
        let data = NSKeyedArchiver.archivedData(withRootObject: info)
        do {
            _ = try data.write(to: URL(fileURLWithPath: filePath))
            Dlog(item: "写入成功")
        } catch {
            Dlog(item: "写入失败：\(error)")
        }
    }
    public static func getUserInfo(){
        let file = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
        // 拼接路径 自动带斜杠的
        let filePath = (file as NSString).appendingPathComponent("UserAccount.archiver")
        let info:EPUserInfo = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? EPUserInfo ?? EPUserInfo()
        EPUserInfo.instance = info
    }
    
}
