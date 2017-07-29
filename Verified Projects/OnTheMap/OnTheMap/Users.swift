//
//  Users.swift
//  OnTheMap
//
//  Created by Joseph Park on 5/3/17.
//  Copyright © 2017 Joseph Park. All rights reserved.
//

import Foundation

class Users: NSObject {
    
    var firstName: String?
    var lastName: String?
    var uniqueKey: String?
    var latitude: Double?
    var longitude: Double?
    var mapString: String?
    var mediaURL: String?
    var objectId: String?
    var updatedAt: String?
    var createdAt: String?
    
    static let sharedInstance : Users = {
        
        let instance = Users()
        return instance
    }()
    
    func updateUdacityUserDetails(studentDictionary: [String:AnyObject]) -> Void {
        
        objectId = studentDictionary[StudentInfoKeys.objectIdKey] as! String?
        createdAt = studentDictionary[StudentInfoKeys.createdAtKey] as! String?
        updatedAt = studentDictionary[StudentInfoKeys.updatedAtKey] as! String?
        firstName = studentDictionary[StudentInfoKeys.firstNameKey] as! String?
        lastName = studentDictionary[StudentInfoKeys.lastNameKey] as! String?
        uniqueKey = studentDictionary[StudentInfoKeys.uniqueKeyKey] as! String?
        latitude = studentDictionary[StudentInfoKeys.latitudeKey] as! Double?
        longitude = studentDictionary[StudentInfoKeys.longitudeKey] as! Double?
        mapString = studentDictionary[StudentInfoKeys.mapStringKey] as! String?
        mediaURL = studentDictionary[StudentInfoKeys.mediaURLKey] as! String?
        
        return
    }

}
