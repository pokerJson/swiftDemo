//
//  LiveHanleJsonModel.swift
//  EcologyPlanet
//
//  Created by dzc on 2021/6/15.
//

import HandyJSON
struct Hasfdfasd: HandyJSON {
    var msg: String?
    var data: yyyy?
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
