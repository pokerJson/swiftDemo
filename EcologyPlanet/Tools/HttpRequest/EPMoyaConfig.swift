import Foundation
import Moya

/**
 1.配置TargetType协议可以一次性处理的参数

 - Todo: 根据自己的需要更改，不能统一处理的移除下面的代码，并在DMAPI中实现

 **/
public extension TargetType {
    var baseURL: URL {
        var baseUrl = ""
        #if DEBUG
        baseUrl = "https://test-k8s-dzq-api.peogoo.com/"
        #else
        baseUrl = "https://zsysinterface.zhaishanying.com/"
        #endif
        return URL(string: baseUrl)!
    }

    var headers: [String : String]? {
        
        return ["Content-Type":"application/json;multipart/form-data","accept":"application/json","token" : "MTg2MTIxMzg2OTE5NzUw"]
    }

    var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
}

/**
2
 **/
extension URLRequest {
    private var commonParams: [String: Any]? {
        return nil
    }
}

//下面的代码不更改
class RequestHandlingPlugin: PluginType {
    public func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var mutateableRequest = request
        return mutateableRequest.appendCommonParams();
    }
}

//下面的代码不更改
extension URLRequest {
    mutating func appendCommonParams() -> URLRequest {
        let request = try? encoded(parameters: commonParams, parameterEncoding: URLEncoding(destination: .queryString))
        assert(request != nil, "append common params failed, please check common params value")
        return request!
    }

    func encoded(parameters: [String: Any]?, parameterEncoding: ParameterEncoding) throws -> URLRequest {
        do {
            return try parameterEncoding.encode(self, with: parameters)
        } catch {
            throw MoyaError.parameterEncoding(error)
        }
    }
}

