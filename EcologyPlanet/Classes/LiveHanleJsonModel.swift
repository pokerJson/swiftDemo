//
//  LiveHanleJsonModel.swift
//  EcologyPlanet
//
//  Created by dzc on 2021/6/15.
//

import HandyJSON
//T泛型 Hasfdfasd是服务器返回的固定参数 其中data字段是根据具体业务返回的 这里用泛型传递 外面用Hasfdfasd<yyyy>
struct Hasfdfasd<T: HandyJSON>: HandyJSON {
    var msg: String?
    var data: T?
    var code: Int?

}

struct yyyy: HandyJSON {
    var currentPage: Int?
    var pageSize: Int?
    var totalCount: Int?
    var totalPage: Int?
    var start: Int?
    var list: [jsModel]?

}
struct jsModel: HandyJSON {
    var id: String?
    var channelId: String?
    var liveId: String?
    var liveToken: String?
    var liveName: String?
    var tutorName: String?

}
