//
//  OldestItemFromPlanet.swift
//  Alien Adventure
//
//  Created by Jarrod Parkes on 10/3/15.
//  Copyright © 2015 Udacity. All rights reserved.
//

extension Hero {
    
    func oldestItemFromPlanet(inventory: [UDItem], planet: String) -> UDItem? {
        var answer: UDItem? = nil
        var maxAge = 0
        
        for item in inventory {
            if let data = item.historicalData["PlanetOfOrigin"] as? String {
                if data == planet {
                    if let age = item.historicalData["CarbonAge"] as? Int {
                        if age >= maxAge {
                            maxAge = age
                            answer = item
                        }
                    }
                }
            }
        }
        return answer
    }
    
}

// If you have completed this function and it is working correctly, feel free to skip this part of the adventure by opening the "Under the Hood" folder, and making the following change in Settings.swift: "static var RequestsToSkip = 2"
