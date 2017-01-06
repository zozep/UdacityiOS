//: [Previous](@previous)

import Foundation
//: ### Exercise 18
//: Mystery code! What does this code do? Briefly, using a few words per line, describe what is happening in each line.

//immutable array with strings created
let array = ["A", "13", "B","5","87", "t", "41"]

//variable sum created and set to 0
var sum = 0

//looping through the array with index called string
for string in array {
    
    //if index(type cast into Int, so non-Int type indices won't be counted) exists
    if Int(string) != nil {
        
        //create constant inToAdd, set it to index, that we know for sure exists
        let intToAdd = Int(string)!
        
        //sum = sum + inToAdd
        sum += intToAdd
    }
}

//print the sum
print(sum)

//: Hint: You may need to look up [Int initializers](http://stackoverflow.com/questions/30739460/toint-removed-in-swift-2) .

//: [Next](@next)
