//
//  liveListModel.swift
//  EcologyPlanet
//
//  Created by dzc on 2021/6/15.
//

//T泛型 LiveListModel是服务器返回的固定参数 其中data字段是根据具体业务返回的 这里用泛型传递 外面用LiveListModel<xxxxx>

struct LiveListModel<T :Codable>: MapCodable {
    var msg: String
    var data: T
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
