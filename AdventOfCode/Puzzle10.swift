//
//  Puzzle4.swift
//  AdventOfCode
//
//  Created by Florent Douine on 05/12/2016.
//  Copyright © 2016 Florent Douine. All rights reserved.
//

import Foundation

class Puzzle10: PuzzleProtocol {
    
    func startResolution() {
        
        let path = "/Users/florent/Documents/projets/AdventOfCode2016/AdventOfCode/Puzzle10.txt";
        var fileContent = "";
        do {
            //fileContent = "value 5 goes to bot 2\nbot 2 gives low to bot 1 and high to bot 0\nvalue 3 goes to bot 1\nbot 1 gives low to output 1 and high to bot 0\nbot 0 gives low to output 2 and high to output 0\nvalue 2 goes to bot 2"
            fileContent = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
        }
        catch {
        }
        
        var bots = [Int: [Int]]()
        var ouput = [Int: Int]()
        
        for string in fileContent.components(separatedBy: "\n"){
            let regex1 = "value ([0-9]+) goes to bot ([0-9]+)"
            
            let i = matches(for: regex1, in: string)
            if !i.isEmpty{
                let val =  Int(i[0])!
                let bot = Int(i[1])!
                if bots[bot]?.isEmpty ?? true {
                    bots[bot] = [val]
                }else{
                    bots[bot]?.append(val);
                    bots[bot]?.sort()
                }
            }
            
            
        }
        global: while true {
        for string in fileContent.components(separatedBy: "\n"){
            let regex2 = "bot ([0-9]+) gives low to (bot|output) ([0-9]+) and high to (bot|output) ([0-9]+)"
            
            let i = matches(for: regex2, in: string)
            if !i.isEmpty{
                let bot = Int(i[0])!
                let isLowOutput = i[1] == "output"
                let lowValue = Int(i[2])!
                let isHighOutput = i[3] == "output"
                let highValue = Int(i[4])!
                
                guard bots[bot]?.isEmpty ?? true == false, bots[bot]?.count ?? 0 == 2, let l = (bots[bot]?[0]), let h = bots[bot]?.last
                     else{
                    continue
                }
                if isLowOutput{
                    ouput[lowValue] = l
                    bots[bot]?.removeFirst()
                    print("Bot \(bot) give \(l) to ouput \(lowValue)")
                }else{
                    if bots[lowValue] == nil {
                        bots[lowValue] = [Int]()
                    }
                    bots[lowValue]?.append(l)
                    bots[lowValue]?.sort()
                    bots[bot]?.removeFirst()
                    print("Bot \(bot) give \(l) to bot \(lowValue)")
                }
                
                
                if isHighOutput{
                    ouput[highValue] = h
                    bots[bot]?.removeFirst()
                    print("Bot \(bot) give \(h) to ouput \(highValue)")
                }else{
                    if bots[highValue] == nil {
                        bots[highValue] = [Int]()
                    }
                    
                    bots[highValue]?.append(h)
                    bots[highValue]?.sort()
                    bots[bot]?.removeLast()
                    print("Bot \(bot) give \(h) to bot \(highValue)")
                }
                
            }
            
            if let f = bots.filter({$0.value == [17, 61]}).first {
                print(f)
                break global
            }
            
            
            
        }
        }
        
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
    
    
    func permutation(_ arr: [Int], actualArr: [Int]) -> [[Int]]{
        
        if(actualArr.count == arr.count){
            return [actualArr]
        }
        
        var ret = [[Int]]();
        
        
        for i in arr {
            if(actualArr.contains(i)){
                continue
            }
            
            var actualCopy = [Int](actualArr)
            actualCopy.append(i)
            let sub = permutation(arr, actualArr: actualCopy);
            
            if(sub.count>0){
                ret.append(contentsOf: sub)
            }
        }
        
        
        return ret;
    }
    
}
