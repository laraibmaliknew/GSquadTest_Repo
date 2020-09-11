//
//  APIRouter.swift
//  GSquadTest
//
//  Created by Apple on 10/09/2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
enum APIRouter {
 //route class for adding more api routes 
    case getPropertyList(data: PropertyListRequestModel)
    // MARK: - HTTPMethod
    private var method: String {
        switch self {
        case .getPropertyList:
            return "post"
        }
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .getPropertyList:
            return "ads"
        }
    }
    
    
    // MARK: - Parameters
    private var parameters: Dictionary<String, Any>? {
        return nil
        
    }
    
    
    // MARK: - URLRequestConvertible
    func asURLRequest() -> URLRequest {
        
        print("Path : \(path)")
        let url =   URL(string: (K.ProductionServer.baseURL+path))
        var urlRequest: URLRequest = URLRequest(url: url!)
        // HTTP Method
        urlRequest.httpMethod = method
        // Common Headers
        urlRequest.setValue(K.ProductionServer.apiKey, forHTTPHeaderField: K.HeaderFields.apiKey)
        urlRequest.setValue(K.ProductionServer.apiToken, forHTTPHeaderField: K.HeaderFields.apiToken)
        urlRequest.setValue("\(K.ProductionServer.userId)", forHTTPHeaderField: K.HeaderFields.userId)
        urlRequest.setValue("\(K.ProductionServer.mlsId)", forHTTPHeaderField: K.HeaderFields.mlsId)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: K.HeaderFields.contentType)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: K.HeaderFields.acceptType)
        switch self {
            case .getPropertyList(let data):
                let encoder  = JSONEncoder()
                urlRequest.httpBody =  try! encoder.encode(data)
                let data = try! encoder.encode(data)
                print(String(data: data, encoding: .utf8)!)
        }
       print("Url Request :  \(urlRequest)")
        return urlRequest
    }
    
    
    
}

