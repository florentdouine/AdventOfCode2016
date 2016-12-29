//
//  Inventory.swift
//  AdventOfCode
//
//  Created by Florent Douine on 29/08/2016.
//  Copyright © 2016 Florent Douine. All rights reserved.
//

import Foundation

struct Inventory {
    var items : [Item]
    
    var armorBonus: Int{
        var tempArmor = 0;
        self.items.forEach({ (item) in
            tempArmor += item.armorBonus;
        })
        return tempArmor;
    }
    
    var damageBonus: Int{
        var tempDamage = 0;
        self.items.forEach({ (item) in
            tempDamage += item.damageBonus;
        })
        return tempDamage;
    }
    
    var cost: Int{
        var tempCost = 0;
        self.items.forEach({ (item) in
            tempCost += item.cost;
        })
        return tempCost;
    }
}