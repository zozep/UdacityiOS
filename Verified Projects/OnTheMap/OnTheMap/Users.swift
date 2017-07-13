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
    
    static let sharedInstance : UdacityUser = {
        
        let instance = UdacityUser()
        return instance
    }()
    
    func updateUdacityUserDetails(studentDict: [String:AnyObject]) -> Void{
        
        objectId = studentDict[StudentInfoKeys.objectIdKey] as! String?
        createdAt = studentDict[StudentInfoKeys.createdAtKey] as! String?
        updatedAt = studentDict[StudentInfoKeys.updatedAtKey] as! String?
        firstName = studentDict[StudentInfoKeys.firstNameKey] as! String?
        lastName = studentDict[StudentInfoKeys.lastNameKey] as! String?
        uniqueKey = studentDict[StudentInfoKeys.uniqueKeyKey] as! String?
        latitude = studentDict[StudentInfoKeys.latitudeKey] as! Double?
        longitude = studentDict[StudentInfoKeys.longitudeKey] as! Double?
        mapString = studentDict[StudentInfoKeys.mapStringKey] as! String?
        mediaURL = studentDict[StudentInfoKeys.mediaURLKey] as! String?
        
        return
    }

}
