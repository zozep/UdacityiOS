//
//  RarityOfItems.swift
//  Alien Adventure
//
//  Created by Jarrod Parkes on 10/4/15.
//  Copyright © 2015 Udacity. All rights reserved.
//

extension Hero {
    
    func rarityOfItems(inventory: [UDItem]) -> [UDItemRarity:Int] {
        
        //initial
        var result: [UDItemRarity: Int] = [.common: 0, .uncommon: 0, .rare: 0, .legendary: 0]
        
        for item in inventory {
            switch item.rarity {
                
            case .common:
                result[.common]! += 1
                
            case .uncommon:
                result[.uncommon]! += 1
                
            case .rare:
                result[.rare]! += 1
                
            case .legendary:
                result[.legendary]! += 1
            
        }
        return result
    }
}

// If you have completed this function and it is working correctly, feel free to skip this part of the adventure by opening the "Under the Hood" folder, and making the following change in Settings.swift: "static var RequestsToSkip = 4"
