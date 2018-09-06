//
//  NetworkService.swift
//  BarberShop-V2
//
//  Created by User on 6/15/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Foundation
import Alamofire
enum APIError: Error {
    case requestFailed
    case jsonConversionFailure
    case invalidData
    case responseUnsuccessful
    case jsonParsingFailure
    
    var localizedDescription: String {
        switch self {
        case .requestFailed: return "Request Failed"
        case .invalidData: return "Invalid Data"
        case .responseUnsuccessful: return "Response Unsuccessful"
        case .jsonParsingFailure: return "JSON Parsing Failure"
        case .jsonConversionFailure: return "JSON Conversion Failure"
        }
    }
}

protocol ServiceNetworkProtocol:class  {
    func fetch<Model: Decodable>(fromRoute route: Route<Model>, decode: @escaping (Decodable) -> Model?, completion: @escaping (Result<Model, APIError>) -> Void)
    //func fetch<Model:Decodable>(fromRoute route: Route<Model>,completion: @escaping (Result<Model>) -> Void)
}
final class GenericNetworkService: ServiceNetworkProtocol {

    

    static let shared = GenericNetworkService()
    typealias JSONTaskCompletionHandler = (Decodable?, APIError?) -> Void
    let baseURL = Routers.basePath
    
    func decodingTask<Model: Decodable>(with route: Route<Model>, decodingType: Model.Type, completionHandler completion: @escaping JSONTaskCompletionHandler) -> DataRequest {
        return
            Alamofire
            .request("\(self.baseURL)\(route.endpoint)")
            .responseData { (response) in
                guard response.error == nil else {
                    completion(nil,APIError.requestFailed)
                    return
                }
                guard let httpResponse = response.response else {
                    completion(nil,APIError.requestFailed)
                    return
                }
                if httpResponse.statusCode == 200 {
                    do {
                        if let data = response.data,
                            let model = try? JSONDecoder().decode(decodingType, from: data){
                            completion(model,nil)
                        }else {
                            completion(nil,APIError.invalidData)
                        }
                    }
                }else {
                    completion(nil,APIError.responseUnsuccessful)
                }
        }
    }
    
    func fetch<Model>(fromRoute route: Route<Model>, decode: @escaping (Decodable) -> Model?, completion: @escaping (Result<Model,APIError>) -> Void) where Model : Decodable {
        let task = decodingTask(with: route, decodingType: Model.self) { (json, error) in
            //MARK: change to main queue
            DispatchQueue.main.async {
                guard let json = json else {
                    if let error = error {
                        completion(Result.failure(error))
                    } else {
                        completion(Result.failure(.invalidData))
                    }
                    return
                }
                if let value = decode(json) {
                    completion(.success(value))
                } else {
                    completion(.failure(.jsonParsingFailure))
                }
            }
            
        }
        task.resume()
}
}
