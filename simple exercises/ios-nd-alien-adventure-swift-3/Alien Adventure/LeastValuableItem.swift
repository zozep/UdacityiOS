//
//  LeastValuableItem.swift
//  Alien Adventure
//
//  Created by Jarrod Parkes on 9/30/15.
//  Copyright © 2015 Udacity. All rights reserved.
//

extension Hero {
    
    func leastValuableItem(inventory: [UDItem]) -> UDItem? {
        var maybeLeastValuableItem: UDItem?
        
        for currentItem in inventory {
            if maybeLeastValuableItem == nil || (maybeLeastValuableItem?.baseValue)! > currentItem.baseValue {
                maybeLeastValuableItem = currentItem
            }
        }
        return maybeLeastValuableItem
    }
}

// If you have completed this function and it is working correctly, feel free to skip this part of the adventure by opening the "Under the Hood" folder, and making the following change in Settings.swift: "static var RequestsToSkip = 4"
