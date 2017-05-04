//
//  Users.swift
//  OnTheMap
//
//  Created by Joseph Park on 5/3/17.
//  Copyright © 2017 Joseph Park. All rights reserved.
//

import Foundation
import MapKit

struct UsersInfo {
    //Users Data
    
    let firstName: String
    let lastName: String
    let mediaURL: String
    let lat: Double
    let long: Double
    let objectId: String
    let uniqueKey: String
    
    
    init?(dictionary: [String: AnyObject]) {
        guard let firstName = dictionary["firstName"] as? String,
            let lastName = dictionary["lastName"] as? String,
            let mediaURL = dictionary["mediaURL"] as? String,
            let lat = dictionary["latitude"] as? Double,
            let long = dictionary["longitude"] as? Double,
            let objectId = dictionary["objectId"] as? String,
            let uniqueKey = dictionary["uniqueKey"] as? String
        else {
            return nil
        }
        self.firstName = firstName
        self.lastName = lastName
        self.mediaURL = mediaURL
        self.lat = lat
        self.long = long
        self.objectId = objectId
        self.uniqueKey = uniqueKey
    }
    
    static func UsersDataResults(_ results: [[String: AnyObject]]) -> [UsersInfo] {
        var usersList = [UsersInfo]()
        
        //User data results
        for result in results {
            if let UsersInfo = UsersInfo(dictionary: result) {
                usersList.append(UsersInfo)
            }
        }
        return usersList
    }
    
    static var UsersArray : [UsersInfo] = []
}
