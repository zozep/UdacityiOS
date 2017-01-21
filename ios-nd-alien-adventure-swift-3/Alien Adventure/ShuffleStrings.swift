//
//  ShuffleStrings.swift
//  Alien Adventure
//
//  Created by Jarrod Parkes on 9/30/15.
//  Copyright © 2015 Udacity. All rights reserved.
//

extension Hero {
    
    func shuffleStrings(s1: String, s2: String, shuffle: String) -> Bool {
        if s1.isEmpty && s2.isEmpty && shuffle.isEmpty {
            return true
        } else if s1.characters.count + s2.characters.count != shuffle.characters.count {
            return false
        } else {
            
            var copy1 : String = ""
            var copy2 : String = ""
            var char : Character
            
            for index in shuffle.characters.indices {
                char = shuffle[index]
                
                for charS1 in s1.characters {
                    if charS1 == char {
                        copy1.append(charS1)
                    }
                }
                for charS2 in s2.characters {
                    if charS2 == char {
                        copy2.append(charS2)
                    }
                }
            }
            
            if copy1 == s1 && copy2 == s2 {
                return true
            } else {
                return false
            }
        }
    }
}
