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
    
    struct ErrorMessage {
        let dataError = "Error Getting Data!"
        let mapError = "Failed To Geocode!"
        let updateError = "Failed To Update Location!"
        let invalidLink = "Invalid Link!"
        let missingLink = "Need To Enter Link!"
        let cantLogin = "Network Connection Is Offline!"
        let invalidEmail = "Invalid Email Or Password!"
        
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
                handleError(error: "Your request returned a status code other than 2xx", errorMessage: self.appDelegate.errorMessage.cantLogin)
            }
    }
}

