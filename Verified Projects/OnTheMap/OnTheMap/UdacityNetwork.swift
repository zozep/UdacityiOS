//
//  UdacityNetwork.swift
//  OnTheMap
//
//  Created by Joseph Park on 5/4/17.
//  Copyright © 2017 Joseph Park. All rights reserved.
//

import Foundation
import UIKit

class UdacityNetwork: NSObject {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override init() {
        super.init()
    }
    
    //Login To Udacity
    
    func getUdacityData(username: String, password: String, completionHandlerForAuth: @escaping (_ success: Bool, _ errorMessage: String?, _ error: NSError?) -> Void) {
        
        let request = NSMutableURLRequest(url: URL(string: "https://www.udacity.com/api/session")!)
        request.httpMethod = "POST"
        request.addValue("applicatoin/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"udacity\": {\"username\": \"\(username)\", \"password\": \"\(password)\"}}".data(using: String.Encoding.utf8)
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            func handleError(error: String, errorMessage: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey: error]
                completionHandlerForAuth(false, errorMessage, NSError(domain: "getUdacityData", code: 1, userInfo: userInfo))
            }
            
            guard (error == nil) else {
                handleError(error: "There was an error with your request: \(String(describing: error))", errorMessage: self.appDelegate.errorMessage.cantLogin)
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                handleError(error: "Your request returned a status code other than 2xx", errorMessage: self.appDelegate.errorMessage.invalidEmail)
                return
            }
            
            guard let data = data else {
                handleError(error: "No data was returned by the request", errorMessage: self.appDelegate.errorMessage.cantLogin)
            }
            
            //Parse the data
            
            let stringData = String(data: data, encoding: String.Encoding.utf8)
            print(stringData ?? "stringData done")
            
            let newData = data.subdata(in: Range(uncheckedBounds: (5, data.count)))
            let stringNewData = String(data: newData, encoding: String.Encoding.utf8)
            print(stringNewData ?? "stringNewData Done")
            
            let parsedResult = try? JSONSerialization.jsonObject(with: newData, options: .allowFragments)
            
            guard let dictionary = parsedResult as? [String: AnyObject] else {
                handleError(error: "Can't parse dict", errorMessage: self.appDelegate.errorMessage.cantLogin)
                return
            }
            
            guard let account = dictionary["account"] as? [String: AnyObject] else {
                handleError(error: "Can't find key 'Account in \(String(describing: parsedResult))", errorMessage: self.appDelegate.errorMessage.cantLogin)
                return
            }
            
            
            //Use the data
            guard let userID = account["key"] as? String else {
                handleError(error: "can't find key 'key' in \(account)", errorMessage: self.appDelegate.errorMessage.CantLogin)
                return
            }
            
            self.appDelegate.userID = userID
            completionHandlerForAuth(true, nil, nil)
        }
        task.resume()
    }
    
    func getUserData(userID: String, completionHandlerForAuth: @escaping (_ success: Bool, _ error: NSError?) -> Void) {
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://www.udacity.com/api/users/\(userID)")! as URL)
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            
            func sendError(error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey: error]
                completionHandlerForAuth(false, NSError(domain: "getUserData", code: 1, userInfo: userInfo))
            }
            
            guard (error == nil) else {
                sendError(error: "There was an error with yout request \(error)")
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                sendError(error: "Your request returned a status code other than 2xx")
                return
            }
            
            guard let data = data else {
                sendError(error: "No data was returned by the request")
                return
            }
            
            //parse data
            let newData = data.subdata(in: Range(uncheckedBounds: (5, data.count)))
            
            let parsedResult: AnyObject!
            do {
                parsedResult = try JSONSerialization.jsonObject(with: newData, options: .allowFragments)
            } catch {
                sendError(error: "Could not parse the data as json \(data)")
                return
            }
            
            guard let dictionary = parsedResult as? [String: AnyObject] else {
                sendError(error: "Cannot parse")
                return
            }
            
            guard let user = dictionary["user"] as? [String: AnyObject] else {
                sendError(error: "cannot find key 'user' in \(parsedResult)")
                return
            }
            
            guard let lastName = user["last_name"] as? String else {
                sendError(error: "can't find key 'last_name' in \(user)")
                return
            }
        }
    }
}
