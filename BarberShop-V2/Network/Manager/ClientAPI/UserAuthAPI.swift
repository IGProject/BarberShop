//
//  UserAuthAPI.swift
//  BarberShop-V2
//
//  Created by User on 11/12/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit
import Alamofire

typealias ClientAPICompletionBlock = (_ values:Any?,_ error:String?) -> Void

struct UserClientAPI {
  func request(userEndPoint:UserEndpoint,completion:@escaping ClientAPICompletionBlock){
    var endpoint: UserEndpoint
    var responseType: APIResponseType
    
    switch userEndPoint {
   
    case .login(let parameter):
     endpoint = UserEndpoint.login(parameter: parameter)
      responseType = .login
    case .compareToken(let parameter):
      endpoint = UserEndpoint.compareToken(parameter: parameter)
      responseType = .compareToken
    case .registerUser(let parameter):
      endpoint = UserEndpoint.registerUser(parameter: parameter)
      responseType = .registerUser
    case .registerSocialUser(let parameter):
      endpoint = UserEndpoint.registerSocialUser(parameter: parameter)
      responseType = .registerSocialUser
    case .getAwardPoint:
      endpoint = UserEndpoint.getAwardPoint
      responseType = .getAwardPoint
    }

  }
}

private extension UserClientAPI {
  enum APIResponseType {
    case login
    case compareToken
    case registerUser
    case registerSocialUser
    case getAwardPoint
  }
  
  //MARK: HandleNetworkRequest
  func handleNetworkRequest(userEndpoint:UserEndpoint,responseType:APIResponseType,completion:@escaping ClientAPICompletionBlock){
    Alamofire.request(userEndpoint).validate(statusCode:200...600).responseJSON { (response) in
      self.handleNetworkResponse(error: response.error, dataResponse: response, apiResponse: responseType, completion: { (values, error) in
        switch userEndpoint {
        case .login(_):
          return completion(nil,error)
        case .compareToken(_):
          return completion(nil,error)
        case .registerUser(_):
          return completion(nil,error)
        case .registerSocialUser(_):
         return completion(nil,error)
        case .getAwardPoint:
          break
        }
      })
    }
  }
  
  //MARK: HandleNetworkResponse
  func handleNetworkResponse(error: Error?,dataResponse: DataResponse<Any>,apiResponse:APIResponseType,completion:@escaping ClientAPICompletionBlock){
    
    if let error = dataResponse.error as? URLError {
      print("error:\(error.code)")
      
      if error.code == URLError.Code.notConnectedToInternet {
        completion(nil,"You appear to be offline. Please check your internet connection.")
      }else if error.code == URLError.Code.timedOut{
        completion(nil,"Service is not reachable at the moment. Please try again later.")
      }
      return
    }
    
    dataResponse.printResponse()
    guard let statusCode = dataResponse.response?.statusCode else { return }
   print(statusCode)
  
  }
  
  //MARK: HandleSuccessResponse
  func handleSuccessResponse(with dataResponse: DataResponse<Any>,response:APIResponseType, completion: @escaping (_ values:Any?) -> Void){
   
    switch response {
    case .login:
      completion(nil)
    case .compareToken:
       completion(nil)
    case .registerUser:
       completion(nil)
    case .registerSocialUser:
       completion(nil)
    case .getAwardPoint:
       completion(nil)
    }
    
  }
  
  //MARK:HandleErrorResponse
  func handleErrorResponse(with statusCode:Int,response: DataResponse<Any>,completion:(_ error:String?) -> Void){
    
    let (_,errorMessage) = handleErrorMessage(with: response)
     completion(errorMessage)
  }
  
  //MARK:HandleErrorMessage
  func handleErrorMessage(with responsse:DataResponse<Any>) -> (BarBerError?,String?){
    guard let error = responsse.result.value else {return (nil,nil)}
    let errorBarber = BarBerError(httpStatusCode: error as? String, source: error as? String, messages: [error as! String], innerExceptions: [error as! String])
    if let message = errorBarber.messages?.first {
      return (errorBarber,message)
    }else if let exception = errorBarber.innerExceptions?.first {
      return (errorBarber,exception)
    }else {
      return (errorBarber ,"Something went wrong. Please try again later.")
    }
  }
}
