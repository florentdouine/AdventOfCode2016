//
//  Puzzle4.swift
//  AdventOfCode
//
//  Created by Florent Douine on 05/12/2016.
//  Copyright © 2016 Florent Douine. All rights reserved.
//

import Foundation

class Puzzle15: PuzzleProtocol {
    
    /*let input = [
        (13, 10),
        (17, 15),
        (19, 17),
        (7, 1),
        (5, 0),
        (3, 1)
    ]*/
    var input = [
        (13, 11),
        (17, 0),
        (19, 1),
        (7, 5),
        (5, 0),
        (3, 1),
        (11, 7)
    ]
    
    func startResolution() {
        var notFound = true
        var tries = 0;
        while notFound {
            tries += 1
            for (i, el) in input.enumerated() {
                let t = (el.1 + 1) % el.0
                input[i] = (el.0, t)
            }
            
            let total = input.reduce(0, {$0 + $1.1})
            notFound = total != 0
            
            
        }
        print(tries)
        
    }
}
