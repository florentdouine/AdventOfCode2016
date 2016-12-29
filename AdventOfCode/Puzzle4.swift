//
//  Puzzle4.swift
//  AdventOfCode
//
//  Created by Florent Douine on 05/12/2016.
//  Copyright © 2016 Florent Douine. All rights reserved.
//

import Foundation

class Puzzle4: PuzzleProtocol {
    
    func startResolution() {
        
        let path = "/Users/florent/Documents/projets/AdventOfCode2016/AdventOfCode/Puzzle4.txt";
        var fileContent = "";
        do {
            fileContent = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
        }
        catch {
        }
        
        var count = 0;
        for string in fileContent.components(separatedBy: "\n") {
            let c = matches(for: "(.*)([0-9]{3})\\[(.*)\\]", in: string)
            
            let room = c[0]
            let sector = Int(c[1])!
            let checksum = c[2]
            
            
            let roomDecypted = decryptName(room, count: sector % 26)
            print(roomDecypted+" "+String(sector))
            /*
            var counts = [String: Int]()
            for char in room.characters {
                let s = String(char)
                if counts[s] == nil {
                    counts[s] = 1
                }else{
                    counts[s] =  counts[s]! + 1
                }
            }
            
            let sortedCounts = (counts.sorted(by: { $0.1 == $1.1 ? $0.0 < $1.0 : $0.1 > $1.1 }))[0...4]
            
            let comparedChecksum = sortedCounts.reduce("", { (result, el) -> String in
                return  result + el.key
            })

            if comparedChecksum == checksum{
                count += sector
            }
            */
            
            
            
        }
        
        print(count)
    }
    
    func decryptName(_ s: String, count: Int) -> String{
        var newString = s
        for _ in 0..<count{
            var pos = -1
            for uni in newString.unicodeScalars {
                pos += 1
                var val = uni.value
                if val == 122 { // If in the range "A"..."Y", just as an example
                    val = 97
                }else{
                    val += 1
                }
                
                let t = UnicodeScalar(val)
                let newChar = String(describing: t!)
                
                newString.replace(pos, newChar)
            }
        }

        return newString
    }
}
