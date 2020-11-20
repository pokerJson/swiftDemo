//
//  EPPageStyle.swift
//  EcologyPlanet
//
//  Created by dzc on 2020/11/18.
//

import UIKit

/// 布局方式
enum LabelLayout {
    case scroll   //滚动
    case divide   //平分
    case center   //居中
}

/// 移动方向
enum MoveDirection {
    case left   //左移
    case right   //右移
}

/// 移动动画
enum MoveAnimation {
    case fastScroll   //快速移动  仿微博效果
    case scroll       //滚动  跟随
}

class EPPageStyle {
    
    var labelHeight: CGFloat = 44            //标签高度
    var labelMargin: CGFloat = 20            //标签间隔
    var labelFont: CGFloat = 15              //标签字体大小
    var labelSelFont: CGFloat = 17          //选中字体大小
    var labelCenterWidth: CGFloat = 70      //居中模式下label的默认宽度
    var lineCenterWidth: CGFloat = 20      //居中模式下line的默认宽度

    var labelLayout: LabelLayout = .scroll   //默认可以滚动
    var moveAnimation: MoveAnimation = .fastScroll  //底部线运动d动画
    
    var isShowBottomLine: Bool = true        //是否显示底部的线
    var isShowColorScale: Bool = true        //是否显示文字颜色动画
    var bottomAlginLabel: Bool = false        //bottomline跟随文字标签宽度  true跟随label的宽度 默认跟随labelText的宽度
    var isShowFontScale: Bool = true        //是否显示font变化动画
    var isFixedLineWidth: Bool = true        //line线的宽度是不是固定的 true的话是lineCenterWidth=20

    var selectColor: UIColor = UIColor(red: 51/255.0, green: 51/255.0, blue: 51/255.0, alpha: 1)  //字体颜色必须为rgb格式 默认红色
    var normalColor: UIColor = UIColor(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1)    //字体颜色必须为rgb格式  默认黑色
    var bottomLineColor: UIColor = UIColor(hexStr: "#C9AB79") ?? UIColor.gray
    
  
}

