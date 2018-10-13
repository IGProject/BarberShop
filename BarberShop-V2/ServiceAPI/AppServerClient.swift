//
//  AppServerClient.swift
//  BarberShop-V2
//
//  Created by User on 9/13/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Alamofire

//------------------//GET//-----------------------------------//
class AppServerClient {
    //MARK:- GetTeam
    enum GetTeamsFailureReason:Int,Error {
        case unAuthorized = 401
        case notFound = 404
    }
    
    typealias GetTeamsResult = Result<Teams,GetTeamsFailureReason>
    typealias GetTeamsCompletion = (_ result: GetTeamsResult) -> Void
    
    func getTeams(completion: @escaping GetTeamsCompletion){
        Alamofire.request("https://96.9.66.134/BarberShopRest/team/list")
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    do {
                        guard let data = response.data else {
                            completion(.failure(nil))
                            return
                        }
                        let teams = try JSONDecoder().decode(Teams.self, from: data)
                        completion(.success(payload: teams))
                    }catch {
                        completion(.failure(nil))
                    }
                case .failure(_):
                    if let statusCode = response.response?.statusCode,
                        let reason = GetTeamsFailureReason(rawValue: statusCode){
                        completion(.failure(reason))
                    }
                    completion(.failure(nil))
                }
        }
    }
}

//MARK: -StyleList
extension AppServerClient {
    enum getStyleListFailureReason: Int,Error {
        case unAuthorized = 401
        case notFound = 404
    }
    
    typealias GetStyleListResult = Result<StyleHair,getStyleListFailureReason>
    typealias GetStyleListsCompletion = (_ result: GetStyleListResult) -> Void
    
    func getStyleLists(completion: @escaping GetStyleListsCompletion) {
        Alamofire.request("https://96.9.66.134/BarberShopRest/style/list")
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    do {
                        guard let data = response.data else {
                            completion(.failure(nil))
                            return
                        }
                        
                        let styleList = try JSONDecoder().decode(StyleHair.self, from: data)
                        completion(.success(payload: styleList))
                    }catch {
                        completion(.failure(nil))
                    }
                case .failure(_):
                    if let statusCode = response.response?.statusCode,
                        let reason = getStyleListFailureReason(rawValue: statusCode){
                        completion(.failure(reason))
                    }
                }
                completion(.failure(nil))
        }
    }
}

//MARK: - location
extension AppServerClient {
    enum GetLocationFailureReason: Int,Error {
        case unAuthorized = 401
        case notFound = 404
    }
    
    typealias GetLocationResult = Result<Locations,GetLocationFailureReason>
    typealias GetLocationsCompletion = (_ result: GetLocationResult) -> Void
    
    func getLocation(completion: @escaping GetLocationsCompletion){
        Alamofire.request("https://96.9.66.134/BarberShopRest/location/list/")
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    do {
                        guard let data = response.data else {
                            completion(.failure(nil))
                            return
                        }
                        let locations = try JSONDecoder().decode(Locations.self, from: data)
                        completion(.success(payload:locations))
                    }catch {
                        completion(.failure(nil))
                    }
                case .failure(_):
                    if let statusCode = response.response?.statusCode,
                        let reason = GetLocationFailureReason(rawValue: statusCode){
                        completion(.failure(reason))
                    }
                    completion(.failure(nil))
                }
        }
    }
}

//MARK: -GetProduct
extension AppServerClient {
    enum GetProductsFailureReason: Int,Error {
        case unAuthorized = 401
        case notFound = 404
    }
    
    typealias GetProductsResult = Result<Products,GetProductsFailureReason>
    typealias GetProductsCompletion = (_ result: GetProductsResult) -> Void
    
    func getProducts(completion: @escaping GetProductsCompletion){
        Alamofire.request("https://96.9.66.134/BarberShopRest/product/list")
        .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    do {
                        guard let data = response.data else {
                            completion(.failure(nil))
                            return
                        }
                        
                        let products = try JSONDecoder().decode(Products.self, from: data)
                        completion(.success(payload: products))
                    }catch {
                        completion(.failure(nil))
                    }
                    
                case .failure(_):
                        if let statusCode = response.response?.statusCode,
                            let reason = GetProductsFailureReason(rawValue: statusCode){
                            completion(.failure(reason))
                        }
                    completion(.failure(nil))
                }
        }
    }
}


//MARK: - GetFindNear
extension AppServerClient {
    enum GetFindNearFailureReason:Int,Error {
        case unAuthorized = 401
        case notFound = 404
    }
    typealias GetFindNearResult = Result<FindNear,GetFindNearFailureReason>
    typealias GetFindNearsCompletion = (_ result: GetFindNearResult) -> Void
    
    func getFindNears(lat:Double,lng:Double,r:Int,completion: @escaping GetFindNearsCompletion){
        Alamofire.request("https://96.9.66.134/BarberShopRest/location/findNear?lat=\(lat)&lng=\(lng)&r=\(r)")
        .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    do {
                        guard let data = response.data else {
                            completion(.failure(nil))
                            return
                        }
                        let findNears = try JSONDecoder().decode(FindNear.self, from: data)
                        completion(.success(payload: findNears))
                    }catch {
                       completion(.failure(nil))
                    }
                case .failure(_):
                    if let statusCode = response.response?.statusCode,
                        let reason = GetFindNearFailureReason(rawValue: statusCode){
                            completion(.failure(reason))
                    }
                    completion(.failure(nil))
                }
        }
    }
}

//------------------//POST//-----------------------------------//

//MARK: - PostRegister
extension AppServerClient {
    // model
    //MARK: - PostRegister
    enum PostRegisterFailureReason: Int, Error {
        case unAuthorized = 401
        case notFound = 404
    }
    
    typealias PostRegisterResult = EmptyResult<PostRegisterFailureReason>
    typealias PostRegisterCompletion = (_ result: PostRegisterResult) -> Void
    
    func postRegister(username:String,phone: String,password: String,type:Int, completion: @escaping PostRegisterCompletion){
        
        let param = ["username":username,
                     "phone":phone,
                     "password":password,
                     //"base64_image":base64_image,
                     "type":type] as [String : Any]
        
        Alamofire.request("https://96.9.66.134/BarberShopRest/register_user", method: .post, parameters: param, encoding: JSONEncoding.default)
        .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                  completion(.success)
                case .failure(_):
                    if let statusCode = response.response?.statusCode,
                        let reason = PostRegisterFailureReason(rawValue: statusCode){
                        completion(.failure(reason))
                    }
                    completion(.failure(nil))
                }
        }
    }
}


//extension AppServerClient {
//    // model
//    //MARK: - PostRegister
//    enum PostSocialRegisterFailureReason: Int, Error {
//        case unAuthorized = 401
//        case notFound = 404
//    }
//
//    typealias PostSocialRegisterResult = EmptyResult<PostSocialRegisterFailureReason>
//    typealias PostSocialRegisterCompletion = (_ result: PostSocialRegisterResult) -> Void
//
//    func postSocialRegister(socialuser:FacebookUser, completion: @escaping PostRegisterCompletion){
//
//        let param = ["username": socialuser,
//                     "email":socialuser.email,
//                     "token":socialuser.token,
//                     "user_id":socialuser.user_id,
//                     "image":socialuser.image,
//                     "type":socialuser.type.rawValue] as [String : Any]
//
//        Alamofire.request("http://192.168.2.193:8000/user/socialRegister", method: .post, parameters: param, encoding: JSONEncoding.default)
//            .validate()
//            .responseJSON { response in
//                switch response.result {
//                case .success:
//                    completion(.success)
//                case .failure(_):
//                    if let statusCode = response.response?.statusCode,
//                        let reason = PostRegisterFailureReason(rawValue: statusCode){
//                        completion(.failure(reason))
//                    }
//                    completion(.failure(nil))
//                }
//        }
//    }
//}
extension AppServerClient {
    //MARK: - Post Booking
    enum PostBookingFailureReason: Int, Error {
        case unAuthorized = 401
        case notFound = 404
    }
    
    typealias PostBookingResult = EmptyResult<PostBookingFailureReason>
    typealias PostBookingCompletion = (_ result: PostBookingResult) -> Void
    
    func postBooking(booking:BookingDetail,completion: @escaping PostBookingCompletion){
        let param = [ "user_id": booking.user_id,
                      "work_time": booking.work_time,
                      "location_id":booking.location_id,
                      "service_id":booking.service_id,
                      "team_id":booking.team_id ] as [String : Any]
        
        Alamofire.request("https://96.9.66.134/BarberShopRest/bookItem/book", method: .post, parameters: param, encoding: JSONEncoding.default)
        .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    completion(.success)
                case .failure(_):
                    if let statusCode = response.response?.statusCode,
                        let reason = PostBookingFailureReason(rawValue: statusCode){
                        completion(.failure(reason))
                    }
                    completion(.failure(nil))
                }
        }
    }
}

//MARK: -PostCancel
extension AppServerClient {
    enum PostCancelFailureReason: Int, Error {
        case unAuthorized = 401
        case notFound = 404
    }
    
    typealias PostCancelResult = EmptyResult<PostCancelFailureReason>
    typealias PostCancelCompletion = (_ result: PostCancelResult) -> Void
    
    func postCancel(cancelbooking:CancelBooking,completion: @escaping PostCancelCompletion){
        let param = ["book_id":cancelbooking.booking_id,
                     "user_reason":cancelbooking.user_reason] as [String : Any]
        Alamofire.request("https://96.9.66.134/BarberShopRest/bookItem/cancel/\(cancelbooking.booking_id)", method: .post, parameters: param, encoding: JSONEncoding.default)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    completion(.success)
                case .failure(_):
                    if let statusCode = response.response?.statusCode,
                        let reason = PostCancelFailureReason(rawValue: statusCode){
                        completion(.failure(reason))
                    }
                    completion(.failure(nil))
                }
        }
        
    }
    
}

//------------------//PATCH:Edit//-----------------------------------//
//MARK: - PatchBooking
extension AppServerClient {
    enum PatchBookingFailureReason: Int,Error {
        case unAuthorized = 401
        case notFound = 404
    }
    
    typealias PatchBookingResult = Result<BookingDetail,PatchBookingFailureReason>
    typealias PatchBookingCompletion = (_ result: PatchBookingResult) -> Void
    
    func patchBooking(editbooking:EditBooking,completion: @escaping PatchBookingCompletion){
        
        let param = ["booking_id":editbooking.booking_id,
                     "user_id":editbooking.user_id,
                     "work_time":editbooking.work_time,
                     "location_id":editbooking.location_id,
                     "seva_id":editbooking.seva_id,
                     "team_id":editbooking.team_id] as [String : Any]
        
        Alamofire.request("https://96.9.66.134/BarberShopRest/editBooking/\(editbooking.booking_id)", method: .post, parameters: param, encoding: JSONEncoding.default)
        .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    do {
                        guard let data = response.data else {
                            completion(.failure(nil))
                            return
                        }
                         let booking = try JSONDecoder().decode(BookingDetail.self, from: data)
                        completion(.success(payload:booking))
                    } catch {
                        completion(.failure(nil))
                    }
                case .failure(_):
                    if let statusCode = response.response?.statusCode,
                        let reason = PatchBookingFailureReason(rawValue: statusCode){
                        completion(.failure(reason))
                    }
                    completion(.failure(nil))
                }
        }
    }
}

