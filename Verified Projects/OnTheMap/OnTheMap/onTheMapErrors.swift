//
//  onTheMapErrors.swift
//  OnTheMap
//
//  Created by Joseph Park on 7/15/17.
//  Copyright © 2017 Joseph Park. All rights reserved.
//

import Foundation

enum onTheMapErrors : Error {
    
    case noError
    case noInternetConnection
    case errorInGetStudentLocations
    case errorInGetUserPublicData
    case errorInGetUserLocationData
    case errorInUpdateStudentLocation
    case errorInPostingStudentLocation
}
