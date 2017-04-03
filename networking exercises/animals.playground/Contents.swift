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
var parsedAnimalsJSON = try! JSONSerialization.jsonObject(with: rawAnimalsJSON!, options: .allowFragments) as! Dictionary

func parseJSONAsDictionary(_ dictionary: Dictionary) {
    /* Start playing with JSON here... */
    guard let photoDictionary = parsedAnimalsJSON["photos"] as? Dictionary else {
        print("error, can't find key 'photos' in \(parsedAnimalJSON)")
        return
    }
    
    
}

parseJSONAsDictionary(parsedAnimalsJSON)
