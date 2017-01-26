//
//  BannedItems.swift
//  Alien Adventure
//
//  Created by Jarrod Parkes on 10/4/15.
//  Copyright © 2015 Udacity. All rights reserved.
//

import Foundation

extension Hero {
    
    func bannedItems(dataFile: String) -> [Int] {
        /*
         Open the plist file located in the main bundle.
         1. Look through the contents of the plist file and determine any items that should be banned.
         2. An item should be banned if it contains the word “laser” in its name and has a carbon age of less than 30.
         3. Return an array containing the ItemID's for any banned items.
         */
    
    var bannedItemIdsAraray = [Int]()
    let bannedItemWord = "Laser"
    let minCarbonAge = 30
    
    let itemPlist = Bundle.main.url(forResource: "ItemList", withExtension: "plist")!
    let itemArray = NSArray(contentsOf: itemPlist) as! [[String: AnyObject]]
    
    for item in itemArray {
        if let itemId = item["ItemID"] as? Int,
            let name = item["Name"] as? String, name.lowercased().contains(bannedItemWord.lowercased()),
            let historicalData = item["HistoricalData"] as? [String: AnyObject],
            let carbonAge = historicalData["CarbonAge"] as? Int, carbonAge < minCarbonAge {
            bannedItemIdsAraray.append(itemId)
        }
    }
        return bannedItemIdsAraray
    }

}

// If you have completed this function and it is working correctly, feel free to skip this part of the adventure by opening the "Under the Hood" folder, and making the following change in Settings.swift: "static var RequestsToSkip = 6"
