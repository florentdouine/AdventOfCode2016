//
//  Puzzle4.swift
//  AdventOfCode
//
//  Created by Florent Douine on 05/12/2016.
//  Copyright © 2016 Florent Douine. All rights reserved.
//

import Foundation

class Puzzle19: PuzzleProtocol {
    
    func startResolution() -> () {
        
        let input = 3014387
        var n = Array(1...input)
        
        var lastElement = input
        while n.count > 1 {
            let el = (n.index(of: lastElement)! + 1) % n.count
            lastElement = n[el]
            let killedIndex = (n.count/2 + el) % n.count
            n.remove(at: killedIndex)
            
            print(n.count)
            
        }
        
        print(n.first!)
        
        
    }

    
    /*
    func startResolution() -> () {
        
        var input = 3014387
        var first = 1
        var multi = 2
        var c = 1
        while input > 1 {
            c += 1
            if input % 2 == 1 {
                first = first + multi
            }else{
                
            }
            
            input = input / 2
            multi *= 2
        }
        
        print(first)
        
        
    }*/
    
}
