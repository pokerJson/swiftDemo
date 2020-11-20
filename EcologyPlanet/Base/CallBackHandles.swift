//
//  CallBackHandles.swift
//  TB
//
//  Created by dzc on 2020/8/12.
//  Copyright © 2020 PHJTYTJ-0003. All rights reserved.
//

import Foundation
//回调-block-闭包 统一部署
//typealias 起别名 相当于oc中的typedefine

//没有参数 无返回值
public typealias HandleNoParam = () -> ()

//只有一个参数 泛型  
public typealias HandleSingleParam<T> = (T) -> ()

//两个参数
public typealias HandleTwoParam<T,A> = (T,A) -> ()
