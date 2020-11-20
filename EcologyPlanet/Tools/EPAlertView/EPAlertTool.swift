//
//  EPAlertTool.swift
//  EcologyPlanet
//
//  Created by dzc on 2020/11/18.
//

import UIKit

class EPAlertTool: NSObject {
    static func show(topTitle:String,content:String,cancelTitle:String,okTitile:String) {
        let alertV = EPAlert.initWith(topTitle: topTitle, content: content, cancelTitle: cancelTitle, okTitile: okTitile)
        alertV.show()
        
        
    }
}

