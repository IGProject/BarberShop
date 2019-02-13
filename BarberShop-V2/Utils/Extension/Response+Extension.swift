//
//  Response+Extension.swift
//  BarberShop-V2
//
//  Created by User on 11/15/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Alamofire

extension DataResponse {
  public func printResponse() {
    #if DEBUG
    debugPrint("--------------------URL Request--------------------")
    debugPrint("Request :", self.request ?? "No Request Found!")  // original URL request
    debugPrint("--------------------URL Response--------------------")
    debugPrint("Response :", self.response ?? "No Response Found!") // URL response
    debugPrint("--------------------Server Data--------------------")
    debugPrint("Response Data :", self.data ?? "No Response Data Found!")     // server data
    debugPrint("--------------------Response Data--------------------")
    debugPrint("Response Result : ", self.result)
    debugPrint("--------------------Response Error--------------------")
    debugPrint("Response Error :", self.error ?? "No Response Error Found!")
    debugPrint("--------------------Status Code--------------------")
    debugPrint("Status Code :", self.response?.statusCode ?? "No Error Code Found!")
    #endif
  }
}

