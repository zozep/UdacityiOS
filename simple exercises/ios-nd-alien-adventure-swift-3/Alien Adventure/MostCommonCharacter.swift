//
//  MostCommonCharacter.swift
//  Alien Adventure
//
//  Created by Jarrod Parkes on 10/4/15.
//  Copyright © 2015 Udacity. All rights reserved.
//

extension Hero {
    
    func mostCommonCharacter(inventory: [UDItem]) -> Character? {
        
        /*
         1. Loop through each item in the inventory and count the number of times each character appears. 
         2. Also, make sure to use the lowercase representation of each item's name. 
            Otherwise, an item named "StarDust" would add 1 to separate counts for 'S' and 's'.
         2. Return the character that appears the most.
        */
        
        var letters = [Character: Int]()
        
        if inventory.count > 0 {
            for item in inventory {
                let itemNameInLowerCase = item.name.lowercased()
                
                for char in itemNameInLowerCase.characters {
                    //print(char)
                    
                    if let existCount = letters[char] {
                        letters[char] = existCount + 1
                    } else {
                        letters[char] = 1
                    }
                }
            }
        } else {
            return nil
        }
        
        var chatThatAppearsMost: Character = "a"
        var max = 0
        
        for (letter, number) in letters {
            if number > max {
                max = number
                chatThatAppearsMost = letter
            }
        }
        return chatThatAppearsMost
    }
}
