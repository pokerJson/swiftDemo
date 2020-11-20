//
//  EPRefresh.swift
//  EcologyPlanet
//
//  Created by dzc on 2020/11/16.
//

import Foundation
import MJRefresh


//单利
class EPRefresh: NSObject {

    static let instance: EPRefresh = {
        let instance = EPRefresh()
        return instance
    } ()
    
    private override init() {}
}

extension EPRefresh {
    func ep_refreshHeaderHandler<T>(tabView: T, callBack: @escaping HandleNoParam) -> MJRefreshNormalHeader {
        guard tabView != nil else { return MJRefreshNormalHeader() }
        
        let mj_header = MJRefreshNormalHeader {
            callBack()
        }
        mj_header.isAutomaticallyChangeAlpha = true
        mj_header.lastUpdatedTimeLabel?.isHidden = true
        mj_header.activityIndicatorViewStyle = .gray
        mj_header.setTitle("下拉刷新", for: .idle)
        mj_header.setTitle("释放刷新", for: .pulling)
        mj_header.setTitle("努力加载中", for: .refreshing)
        mj_header.stateLabel?.textColor = UIColor(hexNum: 0x666666)
        mj_header.stateLabel?.font = UIFont.epFont(size: 12.0)
        return mj_header
    }

    func ep_refreshFooterHandler<T>(tabView: T, callBack: @escaping HandleNoParam,noMoreDataLableText: String = "————  我是有底线的  ————") -> MJRefreshAutoNormalFooter {
        guard tabView != nil else { return MJRefreshAutoNormalFooter()}
        let mj_footer = MJRefreshAutoNormalFooter {
            callBack()
        }
        mj_footer.isAutomaticallyChangeAlpha = true
        mj_footer.activityIndicatorViewStyle = .gray
        mj_footer.isRefreshingTitleHidden = false
        mj_footer.isAutomaticallyRefresh = false
        mj_footer.setTitle("上拉加载更多", for: .idle)
        mj_footer.setTitle("释放刷新", for: .pulling)
        mj_footer.setTitle("努力加载中", for: .refreshing)
        mj_footer.setTitle(noMoreDataLableText, for: .noMoreData)
        mj_footer.stateLabel?.textColor = UIColor(hexNum: 0x666666)
        mj_footer.stateLabel?.font = UIFont.epFont(size: 12.0)
        return mj_footer
    }

}



