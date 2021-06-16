//
//  liveListModel.swift
//  EcologyPlanet
//
//  Created by dzc on 2021/6/15.
//


struct LiveListModel: MapCodable {
    var msg: String
    var data: xxxxx
    var code: Int

}

struct xxxxx: Codable {
    var currentPage: Int
    var pageSize: Int
    var totalCount: Int
    var totalPage: Int
    var start: Int
    var list: [liveModel]
    
}
struct liveModel: Codable {
    var id: String
    var channelId: String
    var liveId: String
    var liveToken: String
    var liveName: String
    var tutorName: String
}
