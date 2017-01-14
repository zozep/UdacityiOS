//
//  ReverseLongestName.swift
//  Alien Adventure
//
//  Created by Jarrod Parkes on 9/30/15.
//  Copyright © 2015 Udacity. All rights reserved.
//

extension Hero {
    func reverseLongestName(inventory: [UDItem]) -> String {
    //1. check if array is empty, return "" if it is
    //2. find the corresponding index (.name) to manipulate
    //3. given conditions 1 & 2 meet, reverse the string
    //4. return that string
        
        var item: UDItem? = inventory.max {
            $0.name.characters.count < $1.name.characters.count
        }
            return item != nil ? String(item!.name.characters.reversed()) : ""
        }
}
// If you have completed this function and it is working correctly, feel free to skip this part of the adventure by opening the "Under the Hood" folder, and making the following change in Settings.swift: "static var RequestsToSkip = 1"
