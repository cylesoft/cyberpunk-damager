//
//  DamageHelper.swift
//  CyberpunkDamager
//
//  Created by cyle gage on 11/27/18.
//  Copyright © 2018 CyleSoft. All rights reserved.
//

import Foundation

class DamageHelper {
    
    // different possible locations that can be hit
    public let locations = [
        1: "head",
        2: "torso",
        3: "torso",
        4: "torso",
        5: "right_arm",
        6: "left_arm",
        7: "right_leg",
        8: "right_leg",
        9: "left_leg",
        10: "left_leg"
    ]
    
    // roll a single die
    private func rollDie(sides: Int) -> Int {
        return Int.random(in: 1 ... sides)
    }
    
    // roll a number of dice with the same number of sides each
    private func rollDice(how_many: Int, sides: Int) -> Int {
        var total = 0
        for _ in 0 ..< how_many {
            let roll = rollDie(sides: sides)
            print("roll result: " + String(roll) + " (d" + String(sides) + ")")
            total += roll
        }
        return total
    }
    
    // roll for damage
    public func rollDamage(number_of_bullets_hit: Int, dice_per_bullet: Int, sides_per_die: Int, extra_damage: Int = 0, called_shot: Bool = false, called_shot_location: String = "unknown") -> Dictionary<String, Array<Int>> {
        // need a hashmap of locations
        var location_damage = [String : [Int]]()
        
        // set initial location, but we'll randomly it per bullet if this wasn't a called shot
        var location = called_shot_location
        
        // for number of bullets hit...
        for _ in 0 ..< number_of_bullets_hit {
            print("===")
            
            // pick a location
            if called_shot == false {
                location = locations[rollDie(sides: 10)] ?? "unknown" // this shouldn't happen but gotta be safe
            }
            
            // then roll the damage dice for that location
            let damage = rollDice(how_many: dice_per_bullet, sides: sides_per_die)
            let total_damage = damage + extra_damage
            
            print("bullet did " + String(damage) + " + " + String(extra_damage) + " = " + String(total_damage) + " damage to " + location)
            
            // add the damage to the hashmap
            if location_damage[location] == nil {
                location_damage[location] = [Int]()
            }
            
            location_damage[location]!.append(total_damage)
        }
        
        print("=== end result ===")
        print(location_damage)
        
        return location_damage
    }
}
