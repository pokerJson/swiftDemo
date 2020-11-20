//  moya封装

import Foundation
import Moya
import MBProgressHUD
import HandyJSON
import Reachability

public class HttpRequest {
    /// 使用moya的请求封装
    ///   requestCodable结合系统的Codablejson转模型
    /// - Parameters:
    ///   - target: TargetType里的枚举值
    ///   - model: model类型
    ///   - cache: 需要单独处理缓存的数据时使用
    ///   - success: 成功的回调
    ///   - error: 连接服务器成功但是数据获取失败
    ///   - failure: 连接服务器失败
   
    public class func requestCodable<T: TargetType, D: Decodable>(target: T, model: D.Type?, cache: ((D?) -> Void)? = nil, success: @escaping((D?) -> Void), failure: ((Int?, String) ->Void)?) {
       
        let provider = MoyaProvider<T>(plugins: [RequestHandlingPlugin()])
        provider.request(target) { result in
            ProgressHUD.hide()
            switch result {
            case let .success(response):
                let model = try? response.map(D.self)
                let dict = try? JSONSerialization.jsonObject(with: response.data, options: .mutableContainers) as? Dictionary<String, Any>
                if dict?["code"] as! Int == 0 {
                    success(model)
                }
            case let .failure(error):
                let statusCode = error.response?.statusCode ?? 0
                let errorCode = "请求出错，错误码：" + String(statusCode)
                failureHandle(failure: failure, stateCode: statusCode, message: error.errorDescription ?? errorCode)
            }
        }
        
        //错误处理 - 弹出错误信息
        func failureHandle(failure: ((Int?, String) ->Void)? , stateCode: Int?, message: String) {
            Alert.show(type: .error, text: message)
            failure?(stateCode ,message)
        }
        
    }
    ///requestHandyJson结合第三方的HandyJson转模型
    public class func requestHandyJson<T: TargetType>(target: T, success: @escaping((_ object: Data) ->Void), failure: ((Int?, String) ->Void)?) {
    
       
        
        let provider = MoyaProvider<T>(plugins: [
            RequestHandlingPlugin()
            ])
        
        provider.request(target) { result in
            ProgressHUD.hide()
            switch result {
            case let .success(response):
                let dict = try? JSONSerialization.jsonObject(with: response.data, options: .mutableContainers) as? Dictionary<String, Any>
                if dict?["code"] as! Int == 0 {
                    success(response.data)
                }
            case let .failure(error):
                let statusCode = error.response?.statusCode ?? 0
                let errorCode = "请求出错，错误码：" + String(statusCode)
                failureHandle(failure: failure, stateCode: statusCode, message: error.errorDescription ?? errorCode)
            }
        }
        
        //错误处理 - 弹出错误信息
        func failureHandle(failure: ((Int?, String) ->Void)? , stateCode: Int?, message: String) {
            Alert.show(type: .error, text: message)
            failure?(stateCode ,message)
        }
        
    }
    ///打印日志
    static let networkLoggerPlugin = NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))
}
