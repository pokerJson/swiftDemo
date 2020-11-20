//
//  EPString.swift
//  EcologyPlanet
//
//  Created by dzc on 2020/11/20.
//
import UIKit

extension String {
    
    /// 富文本点击事件
    /// - Parameters:
    ///   - content: 整体文本
    ///   - tapText: 可点击文本
    ///   - tapColor: 可点击文本颜色
    /// - Returns: 返回富文本
    static func changeToRichText(content: String,tapText: String,tapColor: String) -> NSMutableAttributedString {
        let contentStr: String = content
        let nameStr : NSMutableAttributedString = NSMutableAttributedString(string:contentStr as String)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 6
        paragraphStyle.alignment = .left
        nameStr.addAttributes([NSAttributedString.Key.foregroundColor: UIColor(hexStr: tapColor) ?? UIColor.gray], range: NSMakeRange(0, tapText.count))
        nameStr.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, contentStr.count))
        
        return nameStr
    }
}
