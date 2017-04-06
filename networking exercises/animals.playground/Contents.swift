//
//  animals.playground
//  iOS Networking
//
//  Created by Jarrod Parkes on 09/30/15.
//  Copyright (c) 2015 Udacity. All rights reserved.
//

import Foundation

/* Path for JSON files bundled with the Playground */
var pathForAnimalsJSON = Bundle.main.path(forResource: "animals", ofType: "json")

/* Raw JSON data (...simliar to the format you might receive from the network) */
var rawAnimalsJSON = try? Data(contentsOf: URL(fileURLWithPath: pathForAnimalsJSON!))

/* Error object */
var parsingAnimalsError: Error? = nil

/* Parse the data into usable form */
var parsedAnimalsJSON = try! JSONSerialization.jsonObject(with: rawAnimalsJSON!, options: .allowFragments) as! Dictionary<String, Any>
func parseJSONAsDictionary(_ dictionary: Dictionary<String, Any>) {
   
    /* Start playing with JSON here... */
    guard let photoDictionary = parsedAnimalsJSON["photos"] as? Dictionary <String, Any> else {
        print("error, can't find key 'photos' in \(parsedAnimalsJSON)")
        return
    }
    
    guard let totalNumberOfAnimalsPhotos = photoDictionary["total"] as? Int else {
        print("cannot find key 'total' in \(photoDictionary)")
        return
    }
    
    /* How many photos are in the JSON data set? */
    print(totalNumberOfAnimalsPhotos)
    
    guard let arrayOfPhotosDictionaries = photoDictionary["photo"] as? [[String: AnyObject]] else {
        print("Can't find key 'comment' in \(photoDictionary)")
        return
    }
    
    for (index, photo) in arrayOfPhotosDictionaries.enumerated() {
        guard let commentDict = photo["comment"] as? [String: AnyObject] else {
            print("cant find 'comment in \(photo)")
            return
        }
    }
}
