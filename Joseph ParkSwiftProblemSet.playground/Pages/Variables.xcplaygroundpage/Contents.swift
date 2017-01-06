import UIKit

//: In these exercises, you will create variables and constants, and you will handle simple compiler areas that arise when working with them.
/*:
 ### Exercise 1
 
 For each of the following names and types, create a variable or constant that best represents it:
 
 - gallonsRemainingInTank (Double)
 - ageOfSpecimenInWeeks (Int)
 - studentNickname (String)
 - teaspoonsNutmeg (Float)
 */

var gallonsRemainingInTank: Double,
    ageOfSpecimenInWeeks: Int,
    studentNickName: String,
    teaspoonsNutmeg: Float = 0


//: ### Exercise 2
//: Fix the following compiler errors related to assignment, variables, and constants:
let favoriteLanguage: String = "Swift",
    teaspoonsCinnamon: Int = Int(teaspoonsNutmeg)

gallonsRemainingInTank = 2.0
ageOfSpecimenInWeeks = Int(32.45)


//: ### Exercise 3
//: Below is some code to reverse a string. We've declared the entities stringToReverse and arrayOfCharacters as variables. Rewrite this code to reverse a string using only constants declared with let, no variables. Note: In the new version you may use as many constants as you'd like.
let stringToReverse = "Mutable or Immutable? That is the question.",
    reversedString = String(stringToReverse.characters.reversed())

print(reversedString)


/*:
### Exercise 4
 For the following descriptions, create a variable or constant that best represents it:
- an Int value representing the hunger level of an animal over time.
- an Int value representing the score always required to win a game.
- a String value representing a student’s birthday.
- a String value representing what a user types into the status update area.
*/
var hungerLevel: Int,
    userInputOnStatusUpdateArea: String
let scoreRequirement: Int,
    birthday: String
