//
//  LoginViewModel.swift
//  BarberShop-V2
//
//  Created by User on 5/31/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import RxSwift
import Firebase



//extension Auth {
//    public enum AuthProvider {
//        case emailPassword(String, String)
//        case facebook(String)
//        case google(String, String)
//
//        var credential: AuthCredential {
//            switch self {
//            case .emailPassword(let email, let password):
//                return EmailAuthProvider.credential(withEmail: email, password: password)
//            case .facebook(let accessToken):
//                return FacebookAuthProvider.credential(withAccessToken: accessToken)
//            case .google(let idToken, let accessToken):
//                return GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
//            }
//        }
//    }
//    public enum AuthError: Error {
//        case notInitialized
//    }
//}

//extension Reactive where Base: Auth {
//    private static func parseUserResponse<T>(_ observer:@escaping(SingleEvent<T>) -> Void) -> (T?,Error?) -> Void {
//        return { t,error in
//            if let resultData = t {
//                observer(.success(resultData))
//            }else if let error = error {
//                observer(.error(error))
//            }
//        }
//    }
//    //Email
//    public static func SignIn<T>(withEmail email:String,password:String) -> Single<T>{
//        return Single.create(subscribe: { observer in
//           let auth = Auth.auth()
//            if auth != nil {
//                auth.signIn(withEmail: email, password: password, completion: parseUserResponse(observer) as? AuthDataResultCallback)
//            }else {
//                observer(.error(Auth.AuthError.notInitialized))
//            }
//            return Disposables.create()
//        })
//    }
//
//    //auth
//    public static func SignIn<T>(authProvider: Auth.AuthProvider) -> Single<T>{
//        return Single.create(subscribe: { observer in
//             let auth = Auth.auth()
//            if auth != nil {
//                auth.signInAndRetrieveData(with: authProvider.credential, completion: parseUserResponse(observer) as? AuthDataResultCallback)
//            }else {
//                observer(.error(Auth.AuthError.notInitialized))
//            }
//            return Disposables.create()
//        })
//    }
//
//    //custom
//    public static func SignIn<T>(withCustomToken customToken: String) -> Single<T>{
//        return Single.create(subscribe: { observer in
//            let auth = Auth.auth()
//            if auth != nil {
//                auth.signIn(withCustomToken: customToken, completion: parseUserResponse(observer) as? AuthDataResultCallback)
//            }else {
//                observer(.error(Auth.AuthError.notInitialized))
//            }
//            return Disposables.create()
//        })
//    }
//
//    public static func SignOut() -> Completable{
//        return Completable.create(subscribe: { observer in
//            let auth = Auth.auth()
//            if auth != nil {
//            do {
//                try auth.signOut()
//                observer(.completed)
//            }catch let error {
//                observer(.error(error))
//            }
//            }else {
//                observer(.error(Auth.AuthError.notInitialized))
//            }
//            return Disposables.create()
//        })
//    }
//}
//

//typealias successCompletionRequestBlock = ((_ auth: Auth) -> Void)
//typealias errorCompletionBlock = ((_ error: NSError?) -> Void)
//
//protocol LoginProviderDelegate {
//    func loginProvider(_ loginProvider: Provider,didSucceed auth: Auth)
//    func loginProvider(_ loginProvider: Provider,didError error: NSError)
//}
//
//protocol Provider {
//    var providerType: LoginProviderType {get}
//    var delegate: LoginProviderDelegate? {get set}
//    func login()
//    
//}
//enum LoginProviderType {
//    case Email(String, String)
//    case Facebook(String)
//    case Google(String, String)
//    
//    var credential: AuthCredential {
//        switch self {
//            
//        case .Email(let email, let password):
//            return EmailAuthProvider.credential(withEmail: email, password: password)
//        case .Facebook(let accessToken):
//            return FacebookAuthProvider.credential(withAccessToken: accessToken)
//        case .Google(let idToken, let accessToken):
//            return GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
//        }
//    }
//}

//class LoginProvider: LoginProviderDelegate {
//
//    private var successRequestBlock: successCompletionRequestBlock?
//    private var errorRequestBlock: errorCompletionBlock?
//    private let disposeBag = DisposeBag()
//    private var observble: Observable<Request>?
//
//    var currentProvider: Provider!
//
//    private func login(provider:Provider,completionRequest: @escaping successCompletionRequestBlock,completionError:@escaping errorCompletionBlock) -> Void{
//     self.successRequestBlock = completionRequest
//     self.errorRequestBlock = completionError
//     self.currentProvider = provider
//    //provider.delegate = self
//      provider.login()
//    }
//
//    func rx_login(provider: Provider) -> Observable<String> {
//        return Observable.create({ observer in
//            self.login(provider: provider, completionRequest: { (auth) in
//                let currentUser = Auth.auth().currentUser
//
//            }, completionError: { (error) in
//                observer.onError(error!)
//            })
//            return Disposables.create()
//        })
//
//
//    }
//
//    func loginProvider(_ loginProvider: Provider, didSucceed auth: Auth) {
//        self.successRequestBlock?(auth)
//    }
//
//    func loginProvider(_ loginProvider: Provider, didError error: NSError) {
//        self.errorRequestBlock?(error)
//    }
//}










