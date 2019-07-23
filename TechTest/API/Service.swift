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
    
    enum Uri {
        case healt
        case getQuestions
        case getQuestionWithId
        case createQuestion
        case updateQuestion
        case share
        
        var EndPoints: String {
            switch self {
            case .healt             : return "health"
            case .getQuestions      : return "questions"
            case .getQuestionWithId : return "questions"
            case .createQuestion    : return "questions"
            case .updateQuestion    : return "questions"
            case .share             : return "share"
            }
        }
    }
    
    enum Service: URLRequestConvertible {
        
        case healt
        case getQuestions(limite:Int, offset: Int, filter: String?)
        case getQuestionWithId(id: String)
        case createQuestion(question: Question)
        case updateQuestion(question: UpdateQuestionModel)
        case share(mail: String, url: String)
        
        var method: Alamofire.HTTPMethod {
            switch self {
                
            case .healt:
                return .get
            case .getQuestions:
                return .get
            case .getQuestionWithId:
                return .get
            case .createQuestion:
                return .post
            case .updateQuestion:
                return .put
            case .share:
                return .post
            }
        }
        
        func asURLRequest() throws -> URLRequest {
            let result: (path: String, parameters: [String: AnyObject]?) = {
                switch self {
                    
                case .healt:
                    return (Uri.healt.EndPoints, nil)
                    
                    
                case .getQuestions(let limite, let offset, let filter):
                    var params: [String: AnyObject] = ["limite": limite as AnyObject, "offset": offset as AnyObject]
                    if let q = filter {
                        params["filter"] = q as AnyObject
                    }
                    return (Uri.getQuestions.EndPoints, params)
                    
                case .getQuestionWithId(let id):
                    let params: [String: AnyObject] = ["id": id as AnyObject]
                    return ("questions/\(id)", params)

                case .createQuestion(let question):
                    let params = question.toJSON() as [String : AnyObject]
                    return(Uri.createQuestion.EndPoints, params)
                    
                case .updateQuestion(let question):
                    let params = question.toJSON() as [String : AnyObject]
                    return(Uri.updateQuestion.EndPoints, params)

                case .share(let mail, let url):
                    let params: [String: AnyObject] = ["destination_email": mail as AnyObject, "content_url": url as AnyObject]
                    return(Uri.share.EndPoints, params)

                }
            }()
            
            // MARK: - Set HTTP Header Field
            let base = URL(string: "https://private-anon-1f61d1bd95-blissrecruitmentapi.apiary-mock.com/")!
            let baseAppend = base.appendingPathComponent(result.path).absoluteString.removingPercentEncoding
            let url = URL(string: baseAppend!)
            var urlRequest = URLRequest(url: url!)
            urlRequest.httpMethod = method.rawValue
            
            switch result.path {
            case Uri.createQuestion.EndPoints, Uri.updateQuestion.EndPoints:
                let encoding = try JSONEncoding.default.encode(urlRequest, with: result.parameters)
                return encoding
            default:
                let encoding = try URLEncoding.default.encode(urlRequest, with: result.parameters)
                return encoding
            }
        }
    }
}

extension ApiRequest {
    
    func healt( _ completionHandler: @escaping (Bool?) -> Void) {
        
        DefaultAlamofireManager.sharedManager.request(ApiRouter.Service.healt).validate().responseJSON { (response) in
            completionHandler(true)
        }
    }

    func getQuestions(limite: Int, offset: Int, filter: String?, _ completionHandler: @escaping ([QuestionsList]?, Error?) -> Void) {
        
        DefaultAlamofireManager.sharedManager.request(ApiRouter.Service.getQuestions(limite: limite, offset: offset, filter: filter)).validate().responseArray(completionHandler: { (response: DataResponse<[QuestionsList]>) in
            
            switch response.result {
                
            case .success(let result):
                completionHandler(result, nil)
                
            case .failure(let err):
                completionHandler(nil, err)
            }

        })
    }
    
    func getQuestionDetail(id: String, _ completionHandler: @escaping (QuestionsList?, Error?) -> Void) {
//        let params: [String: AnyObject] = ["id": id as AnyObject]
        DefaultAlamofireManager.sharedManager.request(ApiRouter.Service.getQuestionWithId(id: id)).validate().responseObject { (response: DataResponse<QuestionsList>) in
            switch response.result {
                
            case .success(let result):
                completionHandler(result, nil)
                
            case .failure(let err):
                completionHandler(nil, err)
            }
            }.responseJSON { res in
                print(res)
        }
    }
    
    func createQuestion(question: Question, _ completionHandler: @escaping (Question?, Error?) -> Void) {
        
        DefaultAlamofireManager.sharedManager.request(ApiRouter.Service.createQuestion(question: question)).validate().responseObject { (response: DataResponse<Question>) in
            switch response.result {
                
            case .success(let result):
                completionHandler(result, nil)
                
            case .failure(let err):
                completionHandler(nil, err)
            }
        }
    }

    func updateQuestion(question: UpdateQuestionModel, _ completionHandler: @escaping (Question?, Error?) -> Void) {
        
        DefaultAlamofireManager.sharedManager.request(ApiRouter.Service.updateQuestion(question: question)).validate().responseObject { (response: DataResponse<Question>) in
            switch response.result {
                
            case .success(let result):
                completionHandler(result, nil)
                
            case .failure(let err):
                completionHandler(nil, err)
            }
        }
    }
    
    func share(mail: String, url: String, _ completionHandler: @escaping (Bool?, Error?) -> Void) {
        
        DefaultAlamofireManager.sharedManager.request(ApiRouter.Service.share(mail: mail, url: url)).validate().responseJSON { (response) in
            completionHandler(true, nil)
        }
    }

}
