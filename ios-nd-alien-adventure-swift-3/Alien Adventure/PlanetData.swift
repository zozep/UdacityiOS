//
//  PlanetData.swift
//  Alien Adventure
//
//  Created by Jarrod Parkes on 10/4/15.
//  Copyright © 2015 Udacity. All rights reserved.
//
import Foundation

extension Hero {
    /*  1. Open the JSON file located in the main bundle. To do this, use the dataFile parameter and the
           Bundle.main.url(forResource:withExtension) method.
        2. Look through the JSON data and calculate the total points for each planet.
        3. Return the name of the planet with the highest point total.
     */
    
    func planetData(dataFile: String) -> String {
        let planetDataJSON = Bundle.main.url(forResource:"PlanetData", withExtension: "json")!
        let rawplanetDataJSON = NSData(contentsOf: planetDataJSON)!
        var planetDataArrayFromJSON : [[String: AnyObject]]!
        
        var maxPlanet = ""
        var max = 0
        var totalPoints = 0
        
        do {
            planetDataArrayFromJSON = try! JSONSerialization.jsonObject(with: rawplanetDataJSON as Data, options: JSONSerialization.ReadingOptions()) as! [[String: AnyObject]]
            //print(planetDataArrayFromJSON)
        }
        for item in planetDataArrayFromJSON {
            if let name = item["Name"] as? String {
                if let common = item["CommonItemsDetected"] as? Int{
                    totalPoints += common * 1
                }
                if let uncommon = item["UncommonItemDetected"] as? Int {
                    totalPoints += uncommon * 2
                }
                if let rare = item["CommonItemsDetected"] as? Int {
                    totalPoints += rare * 3
                }
                if let legendary = item["LegendaryItemsDetected"] as? Int{
                    totalPoints += legendary * 4
                }
                if totalPoints >= max {
                    max = totalPoints
                    maxPlanet = name
                }
            }
            totalPoints = 0
        }
        return maxPlanet
    }
}

// If you have completed this function and it is working correctly, feel free to skip this part of the adventure by opening the "Under the Hood" folder, and making the following change in Settings.swift: "static var RequestsToSkip = 7"
