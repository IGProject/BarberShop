//
//  AppServerClient.swift
//  BarberShop-V2
//
//  Created by User on 9/13/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Alamofire

class AppServerClient {
    //MARK: - GetUser
    enum GetUserFailureReason: Int,Error {
        case unAuthorized = 401
        case notFound = 404
    }
    
    typealias GetUsersResult = Result<[SignInModel],GetUserFailureReason>
    typealias GetUsersCompletion = (_ result:GetUsersResult) -> Void
    
    func getUsers(completion:@escaping GetUsersCompletion){
        Alamofire.request("")
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    do {
                        guard let data = response.data else {
                            completion(.failure(nil))
                            return
                        }
                        
                        let friends = try JSONDecoder().decode([SignInModel].self, from: data)
                        completion(.success(payload: friends))
                    } catch {
                        completion(.failure(nil))
                    }
                    
                case .failure(_):
                    if let statusCode = response.response?.statusCode,
                        let reason = GetUserFailureReason(rawValue: statusCode) {
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
    
    typealias GetProductsResult = Result<[ProductDetails],GetProductsFailureReason>
    typealias GetProductsCompletion = (_ result: GetProductsResult) -> Void
    
    func getProducts(completion: @escaping GetProductsCompletion){
        Alamofire.request("")
        .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    do {
                        guard let data = response.data else {
                            completion(.failure(nil))
                            return
                        }
                        
                        let products = try JSONDecoder().decode([ProductDetails].self, from: data)
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

//MARK:- GetTeam
extension AppServerClient {
    enum GetTeamsFailureReason:Int,Error {
        case unAuthorized = 401
        case notFound = 404
    }
    
    typealias GetTeamsResult = Result<[TeamDetails],GetTeamsFailureReason>
    typealias GetTeamsCompletion = (_ result: GetTeamsResult) -> Void
    
    func getTeams(completion: @escaping GetTeamsCompletion){
        Alamofire.request("")
        .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    do {
                        guard let data = response.data else {
                            completion(.failure(nil))
                            return
                        }
                        let teams = try JSONDecoder().decode([TeamDetails].self, from: data)
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
    
    typealias GetStyleListResult = Result<[StyleListModel],getStyleListFailureReason>
    typealias GetStyleListsCompletion = (_ result: GetStyleListResult) -> Void
    
    func getStyleLists(completion: @escaping GetStyleListsCompletion) {
        Alamofire.request("http://192.168.2.253:8000/style/list")
        .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    do {
                        guard let data = response.data else {
                            completion(.failure(nil))
                            return
                        }
                        
                        let styleList = try JSONDecoder().decode([StyleListModel].self, from: data)
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
    
    typealias GetLocationResult = Result<[LocationDetail],GetLocationFailureReason>
    typealias GetLocationsCompletion = (_ result: GetLocationResult) -> Void
    
    func getLocation(completion: @escaping GetLocationsCompletion){
        Alamofire.request("")
        .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    do {
                        guard let data = response.data else {
                            completion(.failure(nil))
                            return
                        }
                        let locations = try JSONDecoder().decode([LocationDetail].self, from: data)
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

//MARK: - GetFindNear
extension AppServerClient {
    enum GetFindNearFailureReason:Int,Error {
        case unAuthorized = 401
        case notFound = 404
    }
    typealias GetFindNearResult = Result<[FindNear],GetFindNearFailureReason>
    typealias GetFindNearsCompletion = (_ result: GetFindNearResult) -> Void
    
    func getFindNears(completion: @escaping GetFindNearsCompletion){
        Alamofire.request("")
        .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    do {
                        guard let data = response.data else {
                            completion(.failure(nil))
                            return
                        }
                        let findNears = try JSONDecoder().decode([FindNear].self, from: data)
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
    
    func postRegister(firstname: String,lastname:String,gender:String,username:String,password:String,image:String,type: Int, completion: @escaping PostRegisterCompletion){
        
        let param = ["f_name": firstname,
                     "l_name":lastname,
                     "sex":gender,
                     "username":username,
                     "password":password,
                     "base64_image":image,
                     "type":type] as [String : Any]
        
        Alamofire.request("", method: .post, parameters: param, encoding: JSONEncoding.default)
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

extension AppServerClient {
    //MARK: - Post Booking
    enum PostBookingFailureReason: Int, Error {
        case unAuthorized = 401
        case notFound = 404
    }
    
    typealias PostBookingResult = EmptyResult<PostBookingFailureReason>
    typealias PostBookingCompletion = (_ result: PostBookingResult) -> Void
    
    func postBooking(user_id:Int,work_time:String,location_id:LocationDetail,service_id:ServicesDetails,team_id:TeamDetails,completion: @escaping PostBookingCompletion){
        let param = [ "user_id": user_id,
                      "work_time": work_time,
                      "location_id":location_id,
                      "service_id":service_id,
                      "team_id":team_id ] as [String : Any]
        Alamofire.request("", method: .post, parameters: param, encoding: JSONEncoding.default)
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

//MARK: - PatchBooking
extension AppServerClient {
    enum PatchBookingFailureReason: Int,Error {
        case unAuthorized = 401
        case notFound = 404
    }
    
    typealias PatchBookingResult = Result<BookingDetail,PatchBookingFailureReason>
    typealias PatchBookingCompletion = (_ result: PatchBookingResult) -> Void
    
    func patchBooking(booking_id:Int,user_id:Int,work_time:String,location_id:BookingDetail,seva_id:ServicesDetails,team_id:TeamDetails,completion: @escaping PatchBookingCompletion){
        
        let param = ["booking_id":booking_id,
                     "user_id":user_id,
                     "work_time":work_time,
                     "location_id":location_id,
                     "seva_id":seva_id,
                     "team_id":team_id] as [String : Any]
        
        Alamofire.request("\(booking_id)", method: .patch, parameters: param, encoding: JSONEncoding.default)
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

//MARK: -PostCancel
extension AppServerClient {
    enum PostCancelFailureReason: Int, Error {
        case unAuthorized = 401
        case notFound = 404
    }
    
    typealias PostCancelResult = EmptyResult<PostCancelFailureReason>
    typealias PostCancelCompletion = (_ result: PostCancelResult) -> Void
    
    func postCancel(book_id:Int,user_reason:String,completion: @escaping PostCancelCompletion){
        let param = ["book_id":book_id,
                     "user_reason":user_reason] as [String : Any]
        Alamofire.request("", method: .post, parameters: param, encoding: JSONEncoding.default)
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
