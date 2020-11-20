//
//  EPCommonClass.swift
//  EcologyPlanet
//
//  Created by dzc on 2020/11/17.
//

import UIKit


//MARK:- 屏幕宽高
let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREENT_HEIGHT = UIScreen.main.bounds.size.height



func RGB(_ r: CGFloat,_ g: CGFloat,_ b: CGFloat,_ a: CGFloat = 1.0) -> UIColor {
    return UIColor.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}

extension NSObject {
    //MARK:- 是否是IPX系列
    public func isMoreThanIphoneX_() -> Bool{
        var isPhonex: Bool = false
        if #available(iOS 11.0,*) {
            isPhonex = (UIApplication.shared.delegate?.window??.safeAreaInsets.bottom)! > 0
        }
        return isPhonex
    }
    public var kNAVBARH: CGFloat{
        isMoreThanIphoneX_() ? 88.0 : 64.0
    }
    public var kStatusH: CGFloat{
        isMoreThanIphoneX_() ? 44.0 : 20.0
    }
    public var kTABBARH: CGFloat{
        isMoreThanIphoneX_() ? 83.0 : 49.0
    }
    public var kScaleWidth: CGFloat{
        SCREEN_WIDTH / 375.0
    }
}




//图片加载
extension UIImageView {
    func setUrl(_ url: String) {
        self.kf.setImage(with: URL(string: url))
    }
}
//MARK:- UIView 常用frame方法分类
extension UIView{
    
    var x:CGFloat{
        get{
            return self.frame.origin.x
        }
        set{
            var frame = self.frame;
            frame.origin.x = newValue
            self.frame = frame
        }
    }
    
    var y:CGFloat{
        get{
            return self.frame.origin.y
        }
        set{
            var frame = self.frame;
            frame.origin.y = newValue
            self.frame = frame
        }
    }
    
    var width:CGFloat{
        get{
            return self.frame.size.width
        }
        set{
            var frame = self.frame;
            frame.size.width = newValue
            self.frame = frame
        }
    }
    
    var height:CGFloat{
        get{
            return self.frame.size.height
        }
        set{
            var frame = self.frame;
            frame.size.height = newValue
            self.frame = frame
        }
    }
    
}


//MARK:手势识别 用于嵌套滚动
extension EPTableView: UIGestureRecognizerDelegate {
    public  func gestureRecognizer(_: UIGestureRecognizer,shouldRecognizeSimultaneouslyWith shouldRecognizeSimultaneouslyWithGestureRecognizer:UIGestureRecognizer) -> Bool {
        return true
    }
}
extension EPScrollView: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_: UIGestureRecognizer,shouldRecognizeSimultaneouslyWith shouldRecognizeSimultaneouslyWithGestureRecognizer:UIGestureRecognizer) -> Bool {
        return true
    }
}

//MARK:富文本点击处理
extension UITapGestureRecognizer {
    func didTapAttributedTextIn(label: UILabel, tapTexts: [String], action: @escaping (String, Int) -> Void) {
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)

        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)

        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines

        let labelSize = label.bounds.size
        textContainer.size = labelSize

        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        let textContainerOffset = CGPoint(x:(labelSize.width - textBoundingBox.size.width)*0.5 - textBoundingBox.origin.x,
                                        y:(labelSize.height - textBoundingBox.size.height)*0.5 - textBoundingBox.origin.y);
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x,
                                                   y: locationOfTouchInLabel.y - textContainerOffset.y);

        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer,
                                                          in: textContainer,
                                                          fractionOfDistanceBetweenInsertionPoints: nil)

        if label.text == nil {
            return;
        }
        
        for e in tapTexts.enumerated() {
            let targetRange: NSRange = (label.text! as NSString).range(of: e.element)
            let isContain = NSLocationInRange(indexOfCharacter, targetRange)
            if isContain {
                action(e.element, e.offset)
            }
        }
    }
}
