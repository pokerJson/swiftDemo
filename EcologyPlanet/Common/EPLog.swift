//
//  EPLog.swift
//  EcologyPlanet
//
//  Created by dzc on 2020/11/16.
//

import Foundation

func Dlog (item : Any, file : String = #file, lineNum : Int = #line){
    #if DEBUG
    let fileName = (file as NSString).lastPathComponent
    print ("fileName:\(fileName)\n lineNum:\(lineNum)\n \(item)")
    #endif
}


