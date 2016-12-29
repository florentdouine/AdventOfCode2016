//
//  Shop.swift
//  AdventOfCode
//
//  Created by Florent Douine on 29/08/2016.
//  Copyright © 2016 Florent Douine. All rights reserved.
//

import Cocoa

class Shop {

    var weapons: [Item] {
        
        return [
            Item(armorBonus: 0, damageBonus: 4, cost: 8, name: "Dagger"),
            Item(armorBonus: 0, damageBonus: 5, cost: 10, name: "Shortsword"),
            Item(armorBonus: 0, damageBonus: 6, cost: 25, name: "Warhammer"),
            Item(armorBonus: 0, damageBonus: 7, cost: 40, name: "Longsword"),
            Item(armorBonus: 0, damageBonus: 8, cost: 74, name: "Greataxe"),
        
        ]
        
    }
    
    var armors: [Item] {
        
        return [
            Item(armorBonus: 1, damageBonus: 0, cost: 13, name: "Leather"),
            Item(armorBonus: 2, damageBonus: 0, cost: 31, name: "Chainmail"),
            Item(armorBonus: 3, damageBonus: 0, cost: 53, name: "Splintmail"),
            Item(armorBonus: 4, damageBonus: 0, cost: 75, name: "Bandedmail"),
            Item(armorBonus: 5, damageBonus: 0, cost: 102, name: "Platemail"),
            
        ]
        
    }
    
    
    var rings: [Item] {
        
        return [
            Item(armorBonus: 0, damageBonus: 1, cost: 25, name: "Damage +1"),
            Item(armorBonus: 0, damageBonus: 2, cost: 50, name: "Damage +2"),
            Item(armorBonus: 0, damageBonus: 3, cost: 100, name: "Damage +3"),
            Item(armorBonus: 1, damageBonus: 0, cost: 20, name: "Defense +1"),
            Item(armorBonus: 2, damageBonus: 0, cost: 40, name: "Defense +2"),
            Item(armorBonus: 3, damageBonus: 0, cost: 80, name: "Defense +3"),
        ]
        
        
    }
    
    var getAllCombinations : [Inventory]{
    
        var inventories = [Inventory]()
        for weapon in self.weapons {
            
            for armor in self.armors {
                for rNumber in 0...2 {
                    let ringsCombinations = self.rings.combinations(self.rings, k: rNumber);
                    for rings in ringsCombinations {
                        
                        var items = [Item]();
                        items.append(weapon);
                        items.appendContentsOf(rings);
                        inventories.append(Inventory(items: items));
                        items.append(armor)
                        inventories.append(Inventory(items: items));
                        
                    }
                }
            }
            
        }
        
        return inventories
        
    }
    
}
