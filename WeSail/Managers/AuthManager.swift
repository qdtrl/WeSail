////
////  AuthManager.swift
////  WeSail
////
////  Created by Quentin Dubut-Touroul on 27/11/2023.
////
//
//import Foundation
//import FirebaseAuth
//import GoogleSignIn
//
//enum GoogleSignInError: Error {
//    case unableToGrabTopViewController
//    case signInPresentingError
//    case signInError
//}
//
//struct User {
//    let uid: String
//    let name: String
//    let email: String?
//    let image: String?
//}
//
//class AuthManager {
//    static let shared = AuthManager()
//    
//    let auth = Auth.auth()
//    
//    func createUserWithEmail(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
//        auth.createUser(withEmail: email, password: password) { authResult, error in
//            guard let result = authResult, error == nil else {
//                completion(.failure(error!))
//                return
//            }
//            let user = User(uid: result.user.uid, name: result.user.displayName ?? "", email: result.user.email ?? "", image: result.user.photoURL?.absoluteString)
//            completion(.success(user))
//        }
//    }
//    
//    func signInWithEmail(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
//        auth.signIn(withEmail: email, password: password) { authResult, error in
//            guard let result = authResult, error == nil else {
//                completion(.failure(error!))
//                return
//            }
//            let user = User(uid: result.user.uid, name: result.user.displayName ?? "", email: result.user.email ?? "", image: result.user.photoURL?.absoluteString)
//            completion(.success(user))
//        }
//    }
//    
//    func signInWithGoogle(completion: @escaping (Result<User, GoogleSignInError>) -> Void) {
//        guard let clientID = Bundle.main.object(forInfoDictionaryKey: "client_id") as? String else { return }
//
//        // Create Google Sign In configuration object.
//        let config = GIDConfiguration(clientID: clientID)
//        GIDSignIn.sharedInstance.configuration = config
//
//        guard let topVC = UIApplication.getTopViewController() else { 
//            completion(.failure(.unableToGrabTopViewController))
//            return 
//        }
//
//        // Start the sign in flow!
//        GIDSignIn.sharedInstance.signIn(withPresenting: topVC) { [unowned self] result, error in
//            guard let user = result?.user,
//                  let idToken = user.idToken?.tokenString,
//                  error == nil
//            else {
//                completion(.failure(.signInPresentingError))
//                return
//            }
//
//            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
//                                                     accessToken: user.accessToken.tokenString)
//
//            auth.signIn(with: credential) { result, error in
//                guard let result = result, error == nil else {
//                    completion(.failure(.signInError))
//                    return
//                }
//                let user = User(uid: result.user.uid, name: result.user.displayName ?? "", email: result.user.email ?? "", image: result.user.photoURL?.absoluteString)
//                completion(.success(user))
//            }
//        }
//    }
//    
//    func signOut(completion: @escaping (Result<Void, Error>) -> Void) {
//        do {
//            try auth.signOut()
//            completion(.success(()))
//        } catch let error {
//            completion(.failure(error))
//        }
//    }
//}
//
//extension UIApplication {
//    class func getTopViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
//        if let nav = base as? UINavigationController {
//            return getTopViewController(base: nav.visibleViewController)
//        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
//            return getTopViewController(base: selected)
//        } else if let presented = base?.presentedViewController {
//            return getTopViewController(base: presented)
//        }
//        return base
//    }
//}
