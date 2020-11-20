//  moya的一个具体的接口实现

import Foundation
import Moya
import Alamofire
import Kingfisher

enum  EPAPI {
    //
    case rankList(Int, Int, Int)
    case upLoadImage(img:UIImage)

}

// 补全【MoyaConfig 3：配置TargetType协议可以一次性处理的参数】中没有处理的参数
extension EPAPI: TargetType {
    //1. 每个接口的相对路径
    //请求时的绝对路径是   baseURL + path
    var path: String {
        switch self {
        case .rankList: return "/liveInfo/liveInfoList"
        case .upLoadImage: return "/oss/putObject"
        }
    }

    //2. 每个接口要使用的请求方式
    var method: Moya.Method {
        return .post
    }
//    var headers: [String : String]? {
////        switch self {
////        case .upLoadImage:
////            return ["Content-Type":"multipart/form-data;application/json","token" : "MTg2MTIxMzg2OTEzODk0"]
////        default:
////            return ["Content-Type":"application/json","accept":"application/json","token" : "MTg2MTIxMzg2OTEzODk0"]
////        }
//        return ["Content-Type":"application/json","accept":"application/json","token" : "MTg2MTIxMzg2OTEzODk0"]
//
//    }
    
    //3. Task是一个枚举值，根据后台需要的数据，选择不同的http task。
    var task: Task {
        var params: [String: Any] = [:]
        switch self {
        case .rankList(let a,let b,let c):
            params = ["pageSize":a,"pageNo":b,"loginType":c]
            return .requestParameters(parameters: params, encoding: Alamofire.JSONEncoding() as ParameterEncoding )
            
        case .upLoadImage(let img):
            let imageData = img.pngData() ?? Data()
            let imageMultipartFormData = MultipartFormData(provider: .data(imageData), name: "file", fileName: "file.png", mimeType: "image/png")
            return .uploadMultipart([imageMultipartFormData])
        }
    }

    
}
