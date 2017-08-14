//
//  UdacityUserAPI.swift
//  OnTheMap
//
//  Created by Joseph Park on 7/10/17.
//  Copyright © 2017 Joseph Park. All rights reserved.
//

import UIKit

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
    
     func getUserLocationData(success: @escaping (_ result: Bool, _ error: Error) -> Void) {
        //wip
        
        do {
            let url = URL(string: URLString.userInfo)
            var urlComponents = URLComponents(string: url!.absoluteString)
            let query = ["\(StudentInfoKeys.uniqueKeyKey)":"\(Users.sharedInstance.uniqueKey)"]
            let dataValue = try JSONSerialization.data(withJSONObject: query, options: JSONSerialization.WritingOptions())
            let qValue = NSString(data: dataValue, encoding: String.Encoding.utf8.rawValue)! as String
            
            urlComponents?.queryItems = [URLQueryItem(name: "where", value: "\(qValue)")]
            
            guard let urlWithParameter = urlComponents?.url else {
                print("urlWithParameter does not exist")
                return
            }
            //print("userInfo url is \(urlWithParameter)")
            
            let request = NSMutableURLRequest(url: urlWithParameter)
            request.addValue(Values.parseAppID, forHTTPHeaderField: Keys.parseAppID)
            request.addValue(Values.APIKey, forHTTPHeaderField: Keys.APIKey)
            
            let task = session.dataTask(with: request as URLRequest) { data, response, error in
                
                guard (error == nil) else {
                    success(false, onTheMapErrors.errorInGetUserLocationData)
                    return
                }
                
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                    success(false, onTheMapErrors.errorInGetUserLocationData)
                    return
                }
                
                guard let data = data else {
                    success(false, onTheMapErrors.errorInGetUserLocationData)
                    return
                }
                
                print(NSString(data: data, encoding: String.Encoding.utf8.rawValue)!)
                
                do {
                    if let jsonData = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: AnyObject] {
                        //print("user json is \(jsonData)")
                        
                        if let userInfoArray = jsonData["results"] as? [[String: AnyObject]], userInfoArray.count > 0 {
                            //print("userInfoArray is \(userInfoArray)")
                            
                            let count = userInfoArray.count
                            let userDictionary = userInfoArray[count - 1]
                            //print("userInfo is \(userDictionary)")
                            
                            let user = Users.sharedInstance
                            user.updateUdacityUserDetails(studentDictionary: userDictionary)
                            //print("shared Instance objectId is \(Users.sharedInstance.objectId)")
                            //print("objectId is \(Users.sharedInstance.objectId)")
                            
                            success(true, onTheMapErrors.noError)
                        
                        } else {
                            print("gettinguserdata")
                            self.getUserPublicData(success: { (result, err) in
                                success(result, err)
                            })
                        }
                    }
        
                } catch {
                    success(false, onTheMapErrors.errorInGetUserLocationData)
                    return
                }
            }
            
            task.resume()
            
        } catch {
            success(false, onTheMapErrors.errorInGetUserLocationData)
            return
        }
    }

    
    func getUserPublicData(success: @escaping (_ result:Bool, _ error : Error) -> Void){
        
        let url = URL(string: URLString.publicUserData+Users.sharedInstance.uniqueKey!)
        let request = NSMutableURLRequest(url: url!)
        request.addValue(Values.parseAppID, forHTTPHeaderField: Keys.parseAppID)
        request.addValue(Values.APIKey, forHTTPHeaderField: Keys.APIKey)
        
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            
            guard (error == nil) else{
                success(false,onTheMapErrors.errorInGetUserPublicData)
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                success(false, onTheMapErrors.errorInGetUserPublicData)
                return
            }
            
            guard let data = data else{
                success(false, onTheMapErrors.errorInGetUserPublicData)
                return
            }
            
            let newData = data.subdata(in: Range(5..<data.count))
            
            print("************** getUserPublicData ********************")
            print(NSString(data: newData, encoding: String.Encoding.utf8.rawValue)!)
            
            do {
                if let jsonData = try  JSONSerialization.jsonObject(with: newData, options:.allowFragments) as? [String:AnyObject]{
                    if let userDetails = jsonData["user"] as? [String:AnyObject], let firstName = userDetails["first_name"], let lastName = userDetails["last_name"]{
                        
                        Users.sharedInstance.firstName = firstName as? String
                        Users.sharedInstance.lastName = lastName as? String
                        success(true, onTheMapErrors.noError)
                        
                    }else{
                        success(false, onTheMapErrors.errorInGetUserPublicData)
                        
                    }
                }
                
            } catch let error {
                print(error)
                success(false, onTheMapErrors.errorInGetUserPublicData)
                
            }
        }
        
        task.resume()
    }
    
    func getStudentLocations(failure: @escaping (_ error: Error) -> Void, success: @escaping (_ result: Bool) -> Void) {
        //WIP
    }
}
