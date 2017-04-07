//  hearthstone.playground
//  iOS Networking
//
//  Created by Joseph Park on 04/06/17.

import Foundation

/* Path for JSON files bundled with the Playground */
var pathForHearthstoneJSON = Bundle.main.path(forResource: "hearthstone", ofType: "json")

/* Raw JSON data (...simliar to the format you might receive from the network) */
var rawHearthstoneJSON = try? Data(contentsOf: URL(fileURLWithPath: pathForHearthstoneJSON!))

/* Error object */
var parsingHearthstoneError: Error? = nil

/* Parse the data into usable form */
var parsedHearthstoneJSON = try! JSONSerialization.jsonObject(with: rawHearthstoneJSON!, options: .allowFragments) as! Dictionary<String, Any>

func parseJSONAsDictionary(_ dictionary: Dictionary<String, Any>) {
    
    var numCostRatioItems = 0
    var sumCostRatio = 0.0
    
    var numCostForRarityItemsDict = [String: Int]()
    var sumCostForRarityDict = [String: Int]()
    
    let rarities = ["Free", "Common"]
    
    for rarity in rarities {
        numCostForRarityItemsDict[rarity] = 0
        sumCostForRarityDict[rarity] = 0
    }
    
    guard let arrayOfBasicSetCardDicts = parsedHearthstoneJSON["Basic"] as? [[String:AnyObject]] else {
        print("Cannot find key 'Basic' in \(parsedHearthstoneJSON)")
        return
    }
}
