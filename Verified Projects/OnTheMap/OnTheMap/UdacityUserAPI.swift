//
//  UdacityUserAPI.swift
//  OnTheMap
//
//  Created by Joseph Park on 7/10/17.
//  Copyright © 2017 Joseph Park. All rights reserved.
//

import Foundation

typealias RequestCompletionHandler = (_ data: Data?, _ response: URLResponse?, _ error: NSError?) -> Void

final class UdacityUserAPI: NSObject {
    //shared session
    var session = URLSession.shared
    
    class func sharedInstance() -> UdacityUserAPI {
        struct Singleton {
            static var sharedInstance = UdacityUserAPI()
        }
        
        return Singleton.sharedInstance
    }
    
    func signInWithUdacityCredentials(userName: String, password: String, completionHandler handler: RequestCompletionHandler?) {
        
        let request = NSMutableURLRequest(url: URL(string: URLString.signIn)!)
        request.httpMethod = "POST"
        request.addValue(Values.contentType, forHTTPHeaderField: Keys.accept)
        request.addValue(Values.contentType, forHTTPHeaderField: Keys.contentType)
        request.httpBody = "{\"udacity\": {\"username\": \"\(userName)\", \"password\": \"\(password)\"}}".data(using: String.Encoding.utf8)


        
    }
    
}
