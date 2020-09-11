//
//  APIClient.swift
//  GSquadTest
//
//  Created by Apple on 10/09/2020.
//  Copyright © 2020 Apple. All rights reserved.
//
import Foundation
enum RequestError: Error {
    case clientError
    case serverError
    case noData
    case dataDecodingError
}
class APIClient {
    //gerneric method to perform api requests
     private static func performRequest<T: Decodable>(route: APIRouter, resultHandler: @escaping (Result<T, RequestError>) -> Void) {
    
        let urlTask =  URLSession.shared.dataTask(with: route.asURLRequest()) { (data, response, error) in
            guard error == nil else {
               resultHandler(.failure(.clientError))
               return
           }
           guard let data = data else {
               resultHandler(.failure(.noData))
               return
           }
           guard let decodedData: T = self.decodedData(data) else {
               resultHandler(.failure(.dataDecodingError))
               return
           }
            guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
                resultHandler(.failure(.serverError))
                return
            }
           resultHandler(.success(decodedData))
        
       }

       urlTask.resume()
   }
    private static func decodedData<T: Decodable>(_ data: Data) -> T? {
        if T.self is String.Type {
            return String(data: data, encoding: .utf8) as? T
        } else {
            let decoder = JSONDecoder()
               return try? decoder.decode(T.self, from: data) 
        }
    }
    
    static func getPropertyList(data : PropertyListRequestModel,resultHandler: @escaping (Result<PropertyListResponseModel, RequestError>) -> Void){
        self.performRequest(route: APIRouter.getPropertyList(data: data)) { (result: Result<PropertyListResponseModel, RequestError>) in
           resultHandler(result)
        }
    }
}
