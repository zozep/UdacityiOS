//: [Previous](@previous)
//: ## Functions 
//: In this these, you will be given the description for functions and their expected output assuming they are implemented correctly. It will be your job to finish the implementations.
//: ### Exercise 14
//: The function `emojiLove` should take two `String` parameters and use them to print a `String` with  the format "stringParameterOne ❤️ stringParameterTwo".
func emojiLove(stringParameterOne: String, stringParameterTwo: String) {
    print("\(stringParameterOne) ❤️ \(stringParameterTwo)")
}
emojiLove(stringParameterOne: "cats", stringParameterTwo: "dogs")


//: ### Exercise 15
//: The function `median` should take three `Int` parameters and return the `Int` value in the middle.
func median(num1: Int, num2: Int, num3: Int) -> Int {
    let numbers = [num1, num2, num3]
    let sorted = numbers.sorted()
 
    return sorted[1]
}
median(num1: 91, num2: 10, num3: 58)


/*:
 ### Exercise 16
 
 The function `beginsWithVowel` should take a single `String` parameter and return a `Bool` indicating whether the input string begins with a vowel. If the input string begins with a vowel return true, otherwise return false.
 
 First, you will want to test if the input string is "". If the input string is "", then return false. Otherwise, you can access the first character of a `String` by using `nameOfString.characters[nameOfString.startIndex]`.
 
 
 **It is assumed that the input string is given in English.**
 
 */
func beginsWithVowel(parameter: String) -> Bool {
    
    if parameter.isEmpty {
        print("Put actual words into the parameter!")
        return false
    } else {
        let comparison = parameter.lowercased().characters[parameter.startIndex]
    
        switch comparison {
        case "a", "e", "i", "o", "u":
            print(comparison)
            return true
        default:
            print("Put actual words into the parameter!")
            return false
        }
    }
}
//beginsWithVowel(parameter: "a")


/*:
 ### Exercise 17
 
 The function `funWithWords` should take a single `String` parameter and return a new `String` that is uppercased if it begins with a vowel or is lowercased if it begins with a consonant.
 
 To uppercase a `String`, use `nameOfString.uppercaseString`. To lowercase a `String`, use `nameOfString.lowercaseString`.
 
 **It is assumed that the input string is given in English.**
 
 Hint: Re-use the `beginsWithVowel` function.
 */
func funWithWords(parameter: String) -> String {
    
    if parameter.isEmpty {
        return ""
    } else {
        let comparison = parameter.characters[parameter.startIndex]
        
        switch comparison {
        case "a", "e", "i", "o", "u":
            return parameter.uppercased()
        default:
            return parameter.lowercased()
        }
    }
}
funWithWords(parameter: "apple")


//: [Next](@next)
