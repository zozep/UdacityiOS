//
//  achievements.playground
//  iOS Networking
//
//  Created by Joseph Park on 04/07/17
//

import Foundation

/* Path for JSON files bundled with the Playground */
var pathForAchievementsJSON = Bundle.main.path(forResource: "achievements", ofType: "json")

/* Raw JSON data (...simliar to the format you might receive from the network) */
var rawAchievementsJSON = try? Data(contentsOf: URL(fileURLWithPath: pathForAchievementsJSON!))

/* Error object */
var parsingAchivementsError: Error? = nil

/* Parse the data into usable form */
var parsedAchievementsJSON = try! JSONSerialization.jsonObject(with: rawAchievementsJSON!, options: .allowFragments) as! Dictionary<String, Any>

func parseJSONAsDictionary(_ dictionary: Dictionary<String, Any>) {
    /* Start playing with JSON here... */
}

parseJSONAsDictionary(parsedAchievementsJSON)
