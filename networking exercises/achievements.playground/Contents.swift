//
//  achievements.playground
//  iOS Networking
//
//  Created by Joseph Park on 04/07/17
//

import Foundation

/* Path for JSON files bundled with the Playground */
var pathForAchievementsJSON = Bundle.main.path(forResource: "achievements", ofType: "json")

/* Raw JSON data (...simliar to the format you might receive from the network) */
var rawAchievementsJSON = try? Data(contentsOf: URL(fileURLWithPath: pathForAchievementsJSON!))

/* Error object */
var parsingAchivementsError: Error? = nil

/* Parse the data into usable form */
var parsedAchievementsJSON = try! JSONSerialization.jsonObject(with: rawAchievementsJSON!, options: .allowFragments) as! Dictionary<String, Any>

func parseJSONAsDictionary(_ dictionary: Dictionary<String, Any>) {
    
    /* Get top level dictionaries for achievements and categories */
    guard let achievementDicts = parsedAchievementsJSON["achievements"] as? [Dictionary<String, Any>] else {
        print("cannot find key 'achievements' in \(parsedAchievementsJSON)")
        return
    }
    
    guard let categoryDicts = parsedAchievementsJSON["categories"] as? [Dictionary<String, Any>] else {
        print("cannot find key 'categories' in \(parsedAchievementsJSON)")
        return
    }

    var pointsTotal = 0
    
    /* Create array to hold the categoryIds for "Matchmaking" categories */
    var matchmakingIds: [Int] = []
    
    /* Create dictionary to store the counts for "Matchmaking" categories */
    var categoryCounts: [Int: Int] = [:]

    /* Store all "Matchmaking" categories */
    for categoryDict in categoryDicts {
        
        if let title = categoryDict["title"] as? String, title == "Matchmaking" {
            
            guard let children = categoryDict["children"] as? [Dictionary<String, Any>] else {
                print("Can't find key 'children' in \(categoryDict)")
                return
            }
            
            for child in children {
                
                guard let categoryId = child["categoryId"] as? Int else {
                    print("Can't find key 'categoryId' in \(child)")
                    return
                }
                
                matchmakingIds.append(categoryId)
            }
        }
    }
    
    for achievementDict in achievementDicts {
        
        /* Add to point total and print if achievement has greater than 10 points */
        guard let points = achievementDict["points"] as? Int else {
            print("can't find key 'points' in \(achievementDict)")
            return
        }
        
        pointsTotal += points
        
        /* How many achievements have a point value greater than 10? */
        if points > 10 {
            print("achivement has point value greater than 10")
        }
        
        /* Learn more about the "Cool Running" achievement */
        if let title = achievementDict["title"] as? String,
            let description = achievementDict["description"] as? String, title == "Cool Running" {
                /* What mission must you complete... */
                print(description)
        }
        
         /* Add to category counts */
        guard let categoryId = achievementDict["categoryId"] as? Int else {
            print("Can't find key 'categoryId' in \(achievementDict)")
            return
        }
        
        /* Does category have a key in dictionary? If not, initialize */
        if categoryCounts[categoryId] == nil {
            categoryCounts[categoryId] = 0
        }
        
        /* Add one to category count */
        if let currentCount = categoryCounts[categoryId] {
            categoryCounts[categoryId] = currentCount + 1
        }
    }
    
    /* What is the average point value for achievements? */
    print("average number of points per achievement is \(Double(pointsTotal)/Double(achievementDicts.count))")
    
    var matchmakingAchievementCount = 0
    
    /* Calculate number of "Matchmaking" achievements */
    for matchmakingId in matchmakingIds {
        if let categoryCount = categoryCounts[matchmakingId] {
            matchmakingAchievementCount += categoryCount
        }
    }
    
    /* How many achievements belong to "Matchmaking" category? */
    print("\(matchmakingAchievementCount) achievements belong to the \"Matchmaking\" category")

}

parseJSONAsDictionary(parsedAchievementsJSON)
