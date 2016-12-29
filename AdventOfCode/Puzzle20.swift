//
//  Puzzle4.swift
//  AdventOfCode
//
//  Created by Florent Douine on 05/12/2016.
//  Copyright © 2016 Florent Douine. All rights reserved.
//

import Foundation

class Puzzle20: PuzzleProtocol {
    
    func startResolution() -> () {
        
        let path = "/Users/florent/Documents/projets/AdventOfCode2016/AdventOfCode/puzzle20.txt";
        var fileContent2 = "";
        do {
            fileContent2 = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
        }
        catch {/* error handling here */}
        
        var number = [(Int, Int)]()
        for n in fileContent2.components(separatedBy: "\n") {
            let m = n.components(separatedBy: "-")
            number.append((Int(m[0])!, Int(m[1])!))
        }
        
        number.sort { (el1, el2) -> Bool in
            return el1.0 < el2.0
        }
        
        var globalRange = [(Int, Int)]()
        for n in number {
            if n == number.first! {
                globalRange.append(n)
            }else{
                var last = globalRange.last!
                if n.0 < last.1{
                    if last.1 < n.1 {
                        last.1 = n.1
                    }
                    globalRange.removeLast()
                    globalRange.append(last)
                }else{
                    //new range
                    globalRange.append(n)
                }
                
            }
        }

        var total = 0
        for i in 0..<globalRange.count {
            let r = globalRange[i]
            if r == globalRange.first! {
                continue
            }
            let l = globalRange[i-1]
            
            total += r.0 - l.1 - 1
        }
        
        print(total)
        
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
