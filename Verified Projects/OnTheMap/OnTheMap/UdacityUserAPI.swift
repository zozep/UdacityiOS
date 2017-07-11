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
        
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            
            if error != nil {
                if let handler = handler {
                    handler(nil, nil, error as NSError?)
                }
                return
            }
            
            guard let data = data else {
                print("No data was returned by request")
                return
            }
            
            //subset response data!
            let newData = data.subdata(in: Range(5..<data.count))
            print(NSString(data: newData, encoding: String.Encoding.utf8.rawValue)!)
            
            if let handler = handler {
                handler(newData, response, error as NSError?)
            }
        }
        task.resume()
    }
    
    func logout(result: @escaping (_ success: Bool) -> Void) {
        //WIP
        let request = NSMutableURLRequest(url: URL(string: URLString.logout)!)
        request.httpMethod = "DELETE"
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        
        for cookie in sharedCookieStorage.cookies! {
            if cookie.name == "XSRF-TOKEN" {
                xsrfCookie = cookie
            }
        }
        
        if let xsrfCookie = xsrfCookie {
            request.setValue(xsrfCookie.value, forHTTPHeaderField: Keys.XSRFToken)
        }
        
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            if error != nil {
                result(false)
                return
            }
            let range = Range(uncheckedBounds: (5, data!.count - 5))
            
            //subset response data
            let newData = data?.subdata(in: range)
            print(NSString(data: newData!, encoding: String.Encoding.utf8.rawValue)!)
            result(true)
        }
        task.resume()
    }
    
    
    
}
