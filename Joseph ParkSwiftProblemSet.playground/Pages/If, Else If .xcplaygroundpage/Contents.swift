//: [Previous](@previous)
import Foundation
/*: 
## If, Else If
 ### Exercise 12: Ship it! Or don't...

 Congratulations! You got a new job! Your job is to review games and ensure that they pass certain criteria before they are released. The criteria are the following:

- has less than 10 bugs
- has music
- has more than 5 levels

To complete this exercise:
 
- Write an if-statement to check if the current game can be released.
- Add your if statement to the function, `checkForRelease(bugs: Int, music: Bool, levels: Int)`.
- If a game meets all three criteria, call the function `release()` within your if statement.
- If a game does not meet one of the criteria, print out a message indicating what needs to be fixed.
 
 To do this, you’ll have access to three variables: `bugs`, `hasMusic`,
  and `numberOfLevels`.

 Change the values of the variables and see how the output changes.
*/

var game = "Slow adventures with Morris the Lorris",
    bugs: Int = 10,
    hasMusic: Bool = true,
    numberOfLevels: Int = 7


func release() {
    print("\(game) is now ready for sale.")
}

func checkForRelease(bugs: Int, music: Bool, levels: Int) {
    if bugs <= 9 && hasMusic && levels > 5 {
        release()
    } else if bugs >= 10 {
        print("The game needs the number of bugs to be less than 10")
    } else if hasMusic == false {
        print("The game needs music")
    } else {
        print("The game needs more than 5 levels")
    }
}
checkForRelease(bugs: 9, music: true, levels: 7)

//: [Next](@next)
