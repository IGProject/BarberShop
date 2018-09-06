//
//  Routers.swift
//  BarberShop-V2
//
//  Created by User on 6/20/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Foundation


struct Route<Model> {
    let endpoint: String
}

struct Routers: URLRouter {
    static var basePath: String {
        return "http://192.168.2.152:8080"
    }
    struct UserSocialRegister: Readable,Creatable,Updatable,Deletable{
        var route: String = "\(Route<UserSocialRegister>(endpoint:"/user/socialRegister"))"
        var urlParams: String!
    }
    
    struct ServiceDetails: Readable,Creatable,Updatable,Deletable {
        var route: String = "\(Route<ServiceDetails>(endpoint:"/seva/list"))"
        var urlParams: String!
    }
    
    struct TeamDetails: Readable,Creatable,Updatable,Deletable {
        var route: String = "\(Route<TeamDetails>(endpoint:"/team/list"))"
        var urlParams: String!
    }
    
    struct LocationDetails: Readable,Creatable,Updatable,Deletable {
        var route: String = "\(Route<LocationDetails>(endpoint:"/location/list/"))"
        var urlParams: String!
    }
    
    struct LocationNearBy: Readable,Creatable,Updatable,Deletable {
        var route: String = "\(Route<LocationNearBy>(endpoint:"/location/findNear?"))"
        var urlParams: String!
    }
    
    struct ProductDetails: Readable,Creatable,Updatable,Deletable {
        var route: String = "\(Route<ProductDetails>(endpoint:"/product/list"))"
        var urlParams: String!
    }
    
    struct Booking: Readable,Creatable,Updatable,Deletable {
        var route: String = "\(Route<Booking>(endpoint:"/bookItem/book"))"
        var urlParams: String!
    }
}
//
//// Would probably move this(below code) to a different file called `ChildRoute.swift`
//protocol hasStatuses {}
//extension hasStatuses where Self: Routable {
//    func status(params: String) -> Routers.Status {
//        var child = Routers.Status(params)
//        child.route = nestedRouteURL(parent: self, child: child)
//        return child
//    }
//
//    func getStatus(params: String) -> RequestConverterProtocol {
//        return nestedRoute(args: urlParams, child: Routers.Status.get())
//    }
//
//    func createStatus(parameters: Parameters) -> RequestConverterProtocol {
//        return nestedRoute(args: urlParams, child: Routers.Status.create(parameters: parameters))
//    }
//
//    func deleteStatus(params: String) -> RequestConverterProtocol {
//        return nestedRoute(args: urlParams, child: Routers.Status.delete(params: params))
//    }
//}
//
//protocol hasComments {}
//extension hasComments where Self: Routable {
//    func comment(params: String) -> Routers.Comment {
//        var child = Routers.Comment(params)
//        child.route = nestedRouteURL(parent: self, child: child)
//        return child
//    }
//
//    func getComment(params: String) -> RequestConverterProtocol {
//        let returnComment = nestedRoute(args: urlParams, child: Routers.Comment.get())
//        return returnComment
//    }
//
//    func createComment(parameters: Parameters) -> RequestConverterProtocol {
//        return nestedRoute(args: urlParams, child: Routers.Comment.create(parameters: parameters))
//    }
//
//    func deleteComment(params: String) -> RequestConverterProtocol {
//        return nestedRoute(args: urlParams, child: Routers.Comment.delete(params: params))
//    }
//
//    func updateComment(params: String, parameters: Parameters) -> RequestConverterProtocol {
//        return nestedRoute(args: urlParams, child: Routers.Comment.update(params: params, parameters: parameters))
//    }
//}
//
//protocol hasPictures {}
//extension hasPictures where Self: Routable {
//    func picture(params: String) -> Routers.Picture {
//        var child = Routers.Picture(params)
//        child.route = nestedRouteURL(parent: self, child: child)
//        return child
//    }
//
//    func getPicture(params: String) -> RequestConverterProtocol {
//        return nestedRoute(args: urlParams, child: Routers.Picture.get())
//    }
//
//    func createPicture(parameters: Parameters) -> RequestConverterProtocol {
//        return nestedRoute(args: urlParams, child: Routers.Picture.create(parameters: parameters))
//    }
//
//    func deletePicture(params: String) -> RequestConverterProtocol {
//        return nestedRoute(args: urlParams, child: Routers.Picture.delete(params: params))
//    }
//
//    func updatePicture(params: String, parameters: Parameters) -> RequestConverterProtocol {
//        return nestedRoute(args: urlParams, child: Routers.Picture.update(params: params, parameters: parameters))
//    }
//}
//
//protocol hasUsers {}
//extension hasUsers where Self: Routable {
//
//    func user(params: String) -> Routers.User {
//        var child = Routers.User(params)
//        child.route = nestedRouteURL(parent: self, child: child)
//        return child
//    }
//
//    func getUser(params: String) -> RequestConverterProtocol {
//        return nestedRoute(args: urlParams, child: Routers.User.get())
//    }
//
//    func createUser(parameters: Parameters) -> RequestConverterProtocol {
//        return nestedRoute(args: urlParams, child: Routers.User.create(parameters: parameters))
//    }
//
//    func updateUser(params: String, parameters: Parameters) -> RequestConverterProtocol {
//        return nestedRoute(args: urlParams, child: Routers.User.update(params: params, parameters: parameters))
//    }
//}
//
//protocol hasPosts {}
//extension hasPosts where Self: Routable {
//
//    func post(params: String) -> Routers.Post {
//        var child = Routers.Post(params)
//        child.route = nestedRouteURL(parent: self, child: child)
//        return child
//    }
//
//    func getPost(params: String) -> RequestConverterProtocol {
//        return nestedRoute(args: urlParams, child: Routers.Post.get())
//    }
//
//    func createPost(parameters: Parameters) -> RequestConverterProtocol {
//        return nestedRoute(args: urlParams, child: Routers.Post.create(parameters: parameters))
//    }
//
//    func updatePost(params: String, parameters: Parameters) -> RequestConverterProtocol {
//        return nestedRoute(args: urlParams, child: Routers.Post.update(params: params, parameters: parameters))
//    }

