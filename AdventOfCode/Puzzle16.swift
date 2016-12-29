//
//  Puzzle4.swift
//  AdventOfCode
//
//  Created by Florent Douine on 05/12/2016.
//  Copyright © 2016 Florent Douine. All rights reserved.
//

import Foundation

class Puzzle16: PuzzleProtocol {
    
    var input = "10111100110001111";//"jlmsuwbz"; //"abc"
    
    func startResolution() {
        
        var size = 35651584
        while(input.characters.count < size){
            input = gC(input)
            print(input.characters.count)
        }
        
        let r = input[0..<size-1]
        
        var n = r
        while (size % 2 == 0){
            var c = ""
            
            //let letters = n.characters.map { String($0) }
            //print(letters)
            
            var lastM = ""
            for (l, m) in n.characters.enumerated() {
                if l % 2 == 1 && l > 0 {
                    let d = lastM + String(m)
                    c += (d == "00" || d == "11") ? "1" : "0"
                }
                lastM = String(m)
            }
            n = c
            size = size/2
        }
        
        print(n)

    }
    
    func gC (_ input: String)-> String{
        var a = input
        var b = String(input.characters.reversed())
        b = b.replacingOccurrences(of: "0", with: "2").replacingOccurrences(of: "1", with: "0").replacingOccurrences(of: "2", with: "1")
        
        let result = a + "0" + b
        
        return result

    }
 
    func combinations( _ arr: [Int], currentArray: [Int], total: Int) -> [[Int]] {
        
        let sum = currentArray.reduce(0, +);
        if(sum==total){
            return [currentArray]
        }else if (sum>total){
            return [];
        }
        
        
        
        var ret = [[Int]]()
        
        var sub = [[Int]]()
        
        
        for i in 0 ..< arr.count {
            
            var remainingArray = arr
            remainingArray.removeSubrange(0..<(i+1))
            
            var subArray = currentArray;
            subArray.append(arr[i]);
            
            
            sub = combinations(remainingArray, currentArray: subArray, total: total)
            
            if(!sub.isEmpty){
                ret.append(sub[0]);
            }
            
        }
        
        return ret
        
        
    }
    
    
}
