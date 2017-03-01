//: [Previous](@previous)
//: ## Strings 
import Foundation
//: ### Exercise 5
//: Write a program that tells you whether or not this string contains the substring "ham".

func checkWord() {
    let word = "shampoo",
        check = "ham"
    
    if word.contains("ham") {
        print("'\(word)' contains the word '\(check)'")
    } else {
        print("'\(word)' does not contain the word '\(check)'")
    }
}
checkWord()


//: ### Exercise 6
//: Declare two strings and concatenate them to create a third string.
let firstString = "abc",
    secondString = "def",
    thirdString = firstString + secondString
var firstStr = "Hello",
    concatStr = firstStr + "World"

print("\(thirdString), \(concatStr)")


//: ### Exercise 7
//: Write a program that deletes all occurrences of the word "like" in the following string.
/* Technically if only 'like' is removed, sentence still contains ' ' and ','. (It's ugly). I removed them to make the sentence look better */
func removeSubString() {
    let lottaLikes = "If like, you wanna learn Swift, like, you should build lots of small apps, cuz it's like, a good way to practice.",
        newSentence = lottaLikes.replacingOccurrences(of: " like,", with: "")
    
    print(newSentence)
}
removeSubString()


//: ### Exercise 8
//: Josie has been saving her pennies and has them all counted up. Using string interpoltaion, write a program that, given a number of pennies, prints out how much money Josie has in dollars and cents.
func changePennies() {
    let numOfPennies = 567,
        dollar: String = "\(numOfPennies / 100)",
        cents: String = "\(numOfPennies % 100)" ,
        totalAmount: String = "$\(dollar).\(cents)"
    
    print(totalAmount)
}
changePennies()


//: ### Exercise 9
//: Use string interpolation to replace the X with an expression for percent monthly earnings spent on rent.
let averageMonthlyEarnings: Float = 2500
var averageRent: Float = 800,
    percentMonthlyEarningsSpentOnRent: String = "\(averageRent / averageMonthlyEarnings * 100)",
    weeklyEarningsString = "On average, millenials spend X% of their income on rent."

print(weeklyEarningsString.replacingOccurrences(of: "X", with: percentMonthlyEarningsSpentOnRent))

//: [Next](@next)
