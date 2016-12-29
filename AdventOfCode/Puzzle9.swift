//
//  Puzzle4.swift
//  AdventOfCode
//
//  Created by Florent Douine on 05/12/2016.
//  Copyright © 2016 Florent Douine. All rights reserved.
//

import Foundation

class Puzzle9: PuzzleProtocol {
    
    func startResolution() {
        
        let path = "/Users/florent/Documents/projets/AdventOfCode2016/AdventOfCode/Puzzle9.txt";
        var fileContent = "";
        do {
            fileContent = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
        }
        catch {
        }
        
        let count =  countCharacters(in: fileContent)
        print(count)
        /*
        var newString = fileContent;
        while newString == "" || newString.contains("("){
            var s = newString
            newString = "";
            
            while true {
                let regex = "\\([0-9]+x[0-9]+\\)"
                
                do {
                    let regex = try NSRegularExpression(pattern: regex)
                    let nsString = s as NSString
                    
                    guard let result = regex.firstMatch(in: s, range: NSRange(location: 0, length: nsString.length)) else {
                        break;
                    }
                    let c = nsString.substring(with: result.range).replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "(", with: "").components(separatedBy: "x")
                    let length = Int(c[0])!
                    let multi = Int(c[1])!
                    if result.range.location>0{
                        newString += s[0..<result.range.location-1]
                    }
                    
                    //let start = result.range.location
                    let end   = result.range.location+result.range.length
                    let endMulti = end+length-1
                    let duplicate = s[end..<endMulti]
                    for _ in 0..<multi{
                        newString += duplicate
                    }
                    
                    if s.characters.count-1 <= endMulti{
                        break;
                    }
                    s = s[endMulti+1..<s.characters.count-1]
                    //let t = s[result.range.location..<result.range.location+result.range.length]
                    //print(newString)
                    
                    
                } catch let error as NSError {
                    print("invalid regex: \(error.localizedDescription)")
                }
                
            }
            print(newString.characters.count)
        }
        print(newString.characters.count)
         */   
    }
    func countCharacters(in string: String)-> Int{
        
        if !string.contains("("){
            return string.characters.count
        }
        
        let regex = "\\([0-9]+x[0-9]+\\)"
        
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let nsString = string as NSString
            
            guard let result = regex.firstMatch(in: string, range: NSRange(location: 0, length: nsString.length)) else {
                return 0
            }
            
            let actualCount = result.range.location
            
            
            let c = nsString.substring(with: result.range).replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "(", with: "").components(separatedBy: "x")
            let length = Int(c[0])!
            let multi = Int(c[1])!
            
            
            //let start = result.range.location
            let end   = result.range.location+result.range.length
            let endMulti = end+length-1
            let duplicate = string[end..<endMulti]
            
            let countSub = actualCount + multi * countCharacters(in: duplicate)
            if string.characters.count-1 <= endMulti{
                return countSub
            }
            
            let remainingString = string[endMulti+1..<string.characters.count-1]
            return countSub + countCharacters(in: remainingString)
            
            
            
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            return 0
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
