//
//  Service.swift
//  TechTest
//
//  Created by Amir Daliri on 19.07.2019.
//  Copyright © 2019 AmirDaliri. All rights reserved.
//

import Foundation
import Alamofire

extension ApiRouter {
    
    enum ServiceEndPoint: String {
        case getMainData = ""
    }
    
    enum Service: URLRequestConvertible {
        
        case getMainData
        
        var method: Alamofire.HTTPMethod {
            switch self {
                
            case .getMainData:
                return .get
            }
        }
        
        func asURLRequest() throws -> URLRequest {
            let result: (path: String, parameters: [String: AnyObject]?) = {
                switch self {
                    
                case .getMainData:
                    return (ServiceEndPoint.getMainData.rawValue, nil)
                    
                }
            }()
            
            // MARK: - Set HTTP Header Field
            let base = URL(string: "")!
            let baseAppend = base.appendingPathComponent(result.path).absoluteString.removingPercentEncoding
            let url = URL(string: baseAppend!)
            var urlRequest = URLRequest(url: url!)
            urlRequest.httpMethod = method.rawValue
            
            switch result.path {
            case ServiceEndPoint.getMainData.rawValue:
                
                let encoding = try URLEncoding.default.encode(urlRequest, with: result.parameters)
                return encoding
            default:
                let encoding = try JSONEncoding.default.encode(urlRequest, with: result.parameters)
                return encoding
            }
        }
    }
}

extension ApiRequest {
    
    /*
    func getMainData( _ completionHandler: @escaping ([Children]?, Error?) -> Void) {
        DefaultAlamofireManager.sharedManager.request(ApiRouter.Service.getMainData).validate().responseObject { (response: DataResponse<BaseModel>) in
            
            switch response.result {
                
            case .success(let result):
                if let childrens = result.data?.children {
                    completionHandler(childrens, nil)
                } else {
                    completionHandler(nil, nil)
                }
                completionHandler(result.data?.children, nil)
            case .failure(let err):
                completionHandler(nil, err)
            }
        }
    }
    */
    
}
