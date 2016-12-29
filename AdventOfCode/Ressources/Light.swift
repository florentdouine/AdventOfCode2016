//
//  Light.swift
//  AdventOfCode
//
//  Created by Florent Douine on 04/09/2016.
//  Copyright © 2016 Florent Douine. All rights reserved.
//

import Cocoa

class Light {
    


    var x: Int
    var y: Int
    var on = 0
    
    init(x: Int, y: Int){
        self.x = x
        self.y = y
    }
    
    func switchOn() {
        self.on = 1;
    }
    
    func switchOff() {
        self.on = max(self.on-1, 0);
    }
    
    func toggle() {
        self.on = self.on+2;
    }
}
