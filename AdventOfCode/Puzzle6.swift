//
//  Puzzle4.swift
//  AdventOfCode
//
//  Created by Florent Douine on 05/12/2016.
//  Copyright © 2016 Florent Douine. All rights reserved.
//

import Foundation

class Puzzle6: PuzzleProtocol {
    
    func startResolution() {
        
        let path = "/Users/florent/Documents/projets/AdventOfCode2016/AdventOfCode/Puzzle6.txt";
        var fileContent = "";
        do {
            fileContent = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
        }
        catch {
        }
        
        var counts = [[String: Int]]()
        for string in fileContent.components(separatedBy: "\n") {
            var pos = 0
            for char in string.characters {
                if counts.count <= pos{
                    counts.append([String: Int]())
                }
                
                let s = String(char)
                
                if counts[pos][s] == nil {
                    counts[pos][s] = 1
                }else{
                    counts[pos][s] =  counts[pos][s]! + 1
                }
                pos += 1
            }
        }
        
        for c in counts {
            
            let sortedCounts = (c.sorted(by: { $0.1 > $1.1 }))
            
            print(sortedCounts[0].key)
        }
        
    }
    
}
