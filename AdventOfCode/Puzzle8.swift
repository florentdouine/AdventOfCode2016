//
//  Puzzle4.swift
//  AdventOfCode
//
//  Created by Florent Douine on 05/12/2016.
//  Copyright © 2016 Florent Douine. All rights reserved.
//

import Foundation

class Puzzle8: PuzzleProtocol {
    
    func startResolution() {
        
        let path = "/Users/florent/Documents/projets/AdventOfCode2016/AdventOfCode/Puzzle8.txt";
        var fileContent = "";
        do {
            fileContent = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
        }
        catch {
        }
        
        let grid = Grid()
        
        global: for string in fileContent.components(separatedBy: "\n") {
            if (string.contains("rect")){
                let raw = matches(for: "rect ([0-9]+)x([0-9]+)", in: string)
                let initialPoint = CGPoint(x: 0, y: 0)
                let d = CGPoint(x:Int(raw[0])!-1, y:Int(raw[1])!-1)
                //let d = CGPoint(x: 4, y: 5)
                grid.turnOnAll(initialPoint, destinationPoint: d)
                
            }else if (string.contains("rotate")){
                let raw = matches(for: "rotate (.*) ([xy])\\=([0-9]+) by ([0-9]+)", in: string)
                let axis = raw[0]
                let lettter = raw[1]
                let co = Int(raw[2])!
                let distance = Int(raw[3])!
                //let co = 5
                //let distance = 6
                grid.decale(axis, coordinate: co, decale: distance)
                
            }
            usleep(30000)
            print(grid.description)
            
        }
        let totalOn = grid.lights.reduce(0, {$0 + $1.reduce(0, {$0 + $1.on})})
        //print(totalOn)
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
