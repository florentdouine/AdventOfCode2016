//
//  Puzzle4.swift
//  AdventOfCode
//
//  Created by Florent Douine on 05/12/2016.
//  Copyright © 2016 Florent Douine. All rights reserved.
//

import Foundation

class Puzzle18: PuzzleProtocol {
    
    func startResolution() -> () {
        
        var input = ".^.^..^......^^^^^...^^^...^...^....^^.^...^.^^^^....^...^^.^^^...^^^^.^^.^.^^..^.^^^..^^^^^^.^^^..^";
        
        var total = 0
        for i in 0..<400000 {
            var newInput = ""
            for c in 0..<input.characters.count {
                if (input[c] as String) == "." {
                    total += 1
                }
                var m = input
                if c == 0 {
                    m = "." + m[c..<c+1]
                }else if c == input.characters.count-1 {
                    m = m[c-1..<c] + "."
                }else{
                    m = m[c-1..<c+1]
                }
                
                newInput += (m == "^^." || m == ".^^" || m == "^.." || m == "..^") ? "^" : "."
                
            }
            input = newInput
        }
        
        
        
        print(total)
        
    }
    
}
